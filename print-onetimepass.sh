#/bin/bash

set -ue -o pipefail

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
SECRET_STR_TXT="${SCRIPT_DIR}/secret_str.txt"

function main(){
    local name="${1:-}"
    local pass_phrase="${2:-}"
    check_args "${name}" "${pass_phrase}"
    local crypted_secret_str="$(cat "${SECRET_STR_TXT}" | grep "${name}" | grep -oE "[^ ]+$")"
    local secret_str="$(echo "${crypted_secret_str}" | openssl enc -d -aes-128-cbc -base64 -A -k "${pass_phrase}")"
    oathtool --totp -d 6 --time-step-size=30s --base32 "${secret_str}"
    return
}

function check_args(){
    local name="${1:-}"
    local pass_phrase="${2:-}"
    if [ "${name}" == "" ]; then
        echo "name (1st argument) is empty. abort process."
        exit 1
    fi
    if echo "${name}" | grep -q " "; then
        echo "name (1st argument) is invalid. Don't include space. abort process."
        exit 1
    fi
    if [ "${pass_phrase}" == "" ]; then
        echo "pass phrase (2nd argument) is empty. abort process."
        exit 1
    fi
}



main "${@}"
exit 0


#/bin/bash

set -ue -o pipefail

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
SECRET_STR_TXT="${SCRIPT_DIR}/secret_str.txt"

function main(){
    local name="${1:-}"
    local secret_str="${2:-}"
    local pass_phrase="${3:-}"
    check_args "${name}" "${secret_str}" "${pass_phrase}"
    local crypted_secret_str="$(echo "${secret_str}" | openssl enc -e -des -base64 -A -k "${pass_phrase}")"
    if cat "${SECRET_STR_TXT}" | grep -q "${name}"; then
        echo "name \"${name}\" is already exist. abort process."
        exit 1
    fi
    echo "${name} ${crypted_secret_str}" >> "${SECRET_STR_TXT}"
    return
}

function check_args(){
    local name="${1:-}"
    local secret_str="${2:-}"
    local pass_phrase="${3:-}"
    if [ "${name}" == "" ]; then
        echo "name (1st argument) is empty. abort process."
        exit 1
    fi
    if echo "${name}" | grep -q " "; then
        echo "name (1st argument) is invalid. Don't include space. abort process."
        exit 1
    fi
    if [ "${secret_str}" == "" ]; then
        echo "secret str (2nd argument) is empty. abort process."
        exit 1
    fi
    if [ "${pass_phrase}" == "" ]; then
        echo "pass phrase (3rd argument) is empty. abort process."
        exit 1
    fi
}



main "${@}"
exit 0

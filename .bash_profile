alias rm='rm -i'
alias cp='cp -i'
alias mv='set -f; mvmv'
function mvmv() {
    echo -n "Are you sure? [Y/n] "
    while : ; do
        read ch
        if [ "${ch}" = "Y" ]; then
            command mv -i $@
            return 0
        elif [ "${ch}" = "n" ] || [ "${ch}" = "N" ]; then
            return 1
        else
            echo -n "[Y/n]"
        fi
    done
    command mv -i $@
}

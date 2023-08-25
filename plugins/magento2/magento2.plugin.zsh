# Magento2 command completion

_m2_format_command () {
  awk '/^- [a-z]+/ { sub(":", "", $2); print $2 }'
}

_m2 () {
  if [ -f ./bin/magento ]; then
    _arguments \
      '1: :->command'\
      '*: :->params'

    case $state in
      command)

      local -a commands
      local -a name

      if [[ $words[2] == *\/ ]]; then
        name=$words[2]
      fi

      commands=(${(f)"$(./bin/magentp help $name --color=0 | _m2_format_command)"})
      compadd -Q -S '' -a -- commands
    esac
  fi
}

compdef _m2 m2

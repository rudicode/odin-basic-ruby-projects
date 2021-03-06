module Colors
  #define some colors
  TXTBLK="\033[0;30m"# Black - Regular
  TXTRED="\033[0;31m"# Red
  TXTGRN="\033[0;32m"# Green
  TXTYLW="\033[0;33m"# Yellow
  TXTBLU="\033[0;34m"# Blue
  TXTPUR="\033[0;35m"# Purple
  TXTCYN="\033[0;36m"# Cyan
  TXTWHT="\033[0;37m"# White
  BLDBLK="\033[1;30m" # Black - Bold
  BLDRED="\033[1;31m" # Red
  BLDGRN="\033[1;32m"# Green
  BLDYLW="\033[1;33m"# Yellow
  BLDBLU="\033[1;34m"# Blue
  BLDPUR="\033[1;35m"# Purple
  BLDCYN="\033[1;36m"# Cyan
  BLDWHT="\033[1;37m"# White
  UNKBLK="\033[4;30m"# Black - Underline
  UNDRED="\033[4;31m"# Red
  UNDGRN="\033[4;32m"# Green
  UNDYLW="\033[4;33m"# Yellow
  UNDBLU="\033[4;34m"# Blue
  UNDPUR="\033[4;35m"# Purple
  UNDCYN="\033[4;36m"# Cyan
  UNDWHT="\033[4;37m"# White
  BAKBLK="\033[40m"  # Black - Background
  BAKRED="\033[41m"  # Red
  BAKGRN="\033[42m"  # Green
  BAKYLW="\033[43m"  # Yellow
  BAKBLU="\033[44m"  # Blue
  BAKPUR="\033[45m"  # Purple
  BAKCYN="\033[46m"  # Cyan
  BAKWHT="\033[47m"  # White
  TXTRST="\033[0m"   # Text Reset

  # color scheme for mastermind
  P0 = []
  P0[0] = "#{TXTWHT}#{BAKBLK}" # gameboard
  P0[1] = "#{TXTBLK}\033[48;5;160m 1 #{P0[0]}"
  P0[2] = "#{TXTBLK}\033[48;5;46m 2 #{P0[0]}"
  P0[3] = "#{TXTBLK}\033[48;5;25m 3 #{P0[0]}"
  P0[4] = "#{TXTBLK}\033[48;5;11m 4 #{P0[0]}"
  P0[5] = "#{TXTBLK}\033[48;5;14m 5 #{P0[0]}"
  P0[6] = "#{TXTBLK}\033[48;5;15m 6 #{P0[0]}"
  P0[7] = "#{BLDBLK}●#{P0[0]}"
  P0[8] = "#{TXTGRN}●#{P0[0]}"
  P0[9] = "#{TXTRED}●#{P0[0]}"

end

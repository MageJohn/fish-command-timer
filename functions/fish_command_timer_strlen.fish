# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#    Copyright (C) 2016-2020 Chuan Ji <chuan@jichu4n.com>                     #
#    Modified by Yuri Pieters <yuri (at) zopatista.com>                       #
#                                                                             #
#    Licensed under the Apache License, Version 2.0 (the "License");          #
#    you may not use this file except in compliance with the License.         #
#    You may obtain a copy of the License at                                  #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
#    Unless required by applicable law or agreed to in writing, software      #
#    distributed under the License is distributed on an "AS IS" BASIS,        #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
#    See the License for the specific language governing permissions and      #
#    limitations under the License.                                           #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# fish_command_timer_strlen:
#
# Command to print out the length of a string. This is required because the expr
# command behaves differently on Linux and OS X. On fish 2.3+, we will use the
# "string" builtin.
if type string > /dev/null 2> /dev/null
  function fish_command_timer_strlen
    string length "$argv[1]"
  end
else if expr length + "1" > /dev/null 2> /dev/null
  function fish_command_timer_strlen
    expr length + "$argv[1]"
  end
else if type wc > /dev/null 2> /dev/null; and type tr > /dev/null 2> /dev/null
  function fish_command_timer_strlen
    echo -n "$argv[1]" | wc -c | tr -d ' '
  end
else
  echo 'No compatible string, expr, or wc commands found, not enabling fish command timer'
  set fish_command_timer_enabled 0
end



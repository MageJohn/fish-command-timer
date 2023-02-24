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

# fish_command_timer_print_time:
#
# Command to print out a timestamp using fish_command_timer_time_format. The
# timestamp should be in seconds. This is required because the "date" command in
# Linux and OS X use different arguments to specify the timestamp to print.
if date --date='@0' '+%s' > /dev/null 2> /dev/null
  # Linux.
  function fish_command_timer_print_time
    date --date="@$argv[1]" +"$fish_command_timer_time_format"
  end
else if date -r 0 '+%s' > /dev/null 2> /dev/null
  # macOS / BSD.
  function fish_command_timer_print_time
    date -r "$argv[1]" +"$fish_command_timer_time_format"
  end
else
  echo 'No compatible date commands found, not enabling fish command timer'
  set fish_command_timer_enabled 0
end

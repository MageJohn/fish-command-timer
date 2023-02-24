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

# Computes whether the postexec hooks should compute command duration.
function fish_command_timer_should_compute
  begin
    set -q fish_command_timer_enabled; and \
    [ "$fish_command_timer_enabled" -ne 0 ]
  end; or \
  begin
    set -q fish_command_timer_export_cmd_duration_str; and \
    [ "$fish_command_timer_export_cmd_duration_str" -ne 0 ]
  end
end



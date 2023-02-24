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

# Computes the command duration string (e.g. "3m5s016").
function fish_command_timer_compute_cmd_duration_str
  set -l SEC 1000
  set -l MIN 60000
  set -l HOUR 3600000
  set -l DAY 86400000

  set -l num_days (math -s0 "$CMD_DURATION / $DAY")
  set -l num_hours (math -s0 "$CMD_DURATION % $DAY / $HOUR")
  set -l num_mins (math -s0 "$CMD_DURATION % $HOUR / $MIN")
  set -l num_secs (math -s0 "$CMD_DURATION % $MIN / $SEC")
  set -l num_millis (math -s0 "$CMD_DURATION % $SEC")
  set -l cmd_duration_str ""
  if [ $num_days -gt 0 ]
    set cmd_duration_str {$cmd_duration_str}{$num_days}"d "
  end
  if [ $num_hours -gt 0 ]
    set cmd_duration_str {$cmd_duration_str}{$num_hours}"h "
  end
  if [ $num_mins -gt 0 ]
    set cmd_duration_str {$cmd_duration_str}{$num_mins}"m "
  end
  set -l num_millis_pretty ''
  if begin
      set -q fish_command_timer_millis; and \
      [ "$fish_command_timer_millis" -ne 0 ]
     end
    set num_millis_pretty (printf '%03d' $num_millis)
  end
  set cmd_duration_str {$cmd_duration_str}{$num_secs}s{$num_millis_pretty}
  echo $cmd_duration_str
end



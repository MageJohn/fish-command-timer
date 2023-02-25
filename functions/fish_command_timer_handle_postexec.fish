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

function fish_command_timer_handle_postexec
  set -l last_status $status
  set -l command_end_time (date '+%s')

  if not fish_command_timer_should_compute
    return
  end

  set -l cmd_duration_str (fish_command_timer_compute_cmd_duration_str)
  if begin
      set -q fish_command_timer_export_cmd_duration_str; and \
      [ "$fish_command_timer_export_cmd_duration_str" -ne 0 ]
     end
    set CMD_DURATION_STR "$cmd_duration_str"
  end

  if not begin
      set -q fish_command_timer_enabled; and \
      [ "$fish_command_timer_enabled" -ne 0 ]
      end
    return
  end
  if set -q fish_command_timer_min_cmd_duration; and \
      [ "$fish_command_timer_min_cmd_duration" -gt "$CMD_DURATION" ]; and begin
        [ "$last_status" -eq 0 ]; or \
        not set -q fish_command_timer_status_enabled; or \
        [ "$fish_command_timer_status_enabled" -eq 0 ]
      end
    return
  end


  # Compute timing string (e.g. [ 1s016 | Oct 01 11:11PM ])
  set -l timing_str
  set -l now_str (fish_command_timer_print_time $command_end_time)
  if [ -n "$now_str" ]
    set timing_str "[ $cmd_duration_str | $now_str ]"
  else
    set timing_str "[ $cmd_duration_str ]"
  end
  set -l timing_str_length (string length -- $timing_str)

  # Compute timing string with color.
  set -l timing_str_colored
  if begin
       set -q fish_command_timer_color; and \
       [ -n "$fish_command_timer_color" ]
     end
    set timing_str_colored (set_color $fish_command_timer_color)"$timing_str"(set_color normal)
  else
    set timing_str_colored "$timing_str"
  end

  # Compute status string (e.g. [ SIGINT ])
  set -l status_str ""
  if begin
      set -q fish_command_timer_status_enabled; and \
      [ "$fish_command_timer_status_enabled" -ne 0 ]
     end
    set -l signal (fish_status_to_signal $last_status)
    set status_str "[ $signal ]"
  end
  set -l status_str_length (string length -- $status_str)

  # Compute status string with color.
  set -l status_str_colored
  if begin
      [ $last_status -eq 0 ]; and \
      set -q fish_command_timer_success_color; and \
      [ -n "$fish_command_timer_success_color" ]
      end
    set status_str_colored (set_color $fish_command_timer_success_color)"$status_str"(set_color normal)
  else if begin
      [ $last_status -ne 0 ]; and \
      set -q fish_command_timer_fail_color; and \
      [ -n "$fish_command_timer_fail_color" ]
      end
    set status_str_colored (set_color --bold $fish_command_timer_fail_color)"$status_str"(set_color normal)
  else
    set status_str_colored "$status_str"
  end

  # Combine status string and timing string.
  set -l output_length (math $timing_str_length + $status_str_length + 1)

  # Move to the end of the line. This will NOT wrap to the next line.
  echo -ne "\033["{$COLUMNS}"C"
  # Move back output_length columns.
  echo -ne "\033["{$output_length}"D"
  # Finally, print output.
  echo -e "$status_str_colored $timing_str_colored"
end


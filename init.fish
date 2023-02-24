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

# A fish shell script for printing execution time for each command.
#
# For the most up-to-date version, as well as further information and
# installation instructions, please visit the GitHub project page at
#     https://github.com/jichu4n/fish-command-timer
#
# Requires fish 2.2 or above.

# SETTINGS
# ========
#
# Whether to enable the command timer by default.
#
# To temporarily disable the command timer, type the following
# in a session:
#     set fish_command_timer_enabled 0
# To re-enable:
#     set fish_command_timer_enabled 1
if not set -q fish_command_timer_enabled
  set -g fish_command_timer_enabled 1
end
# Whether to display the exit status of the previous command.
if not set -q fish_command_timer_status_enabled
  set -g fish_command_timer_status_enabled 0
end

# The color of the output.
#
# This should be a color string accepted by fish's set_color command, as
# described here:
#
#     http://fishshell.com/docs/current/commands.html#set_color
#
# If empty, disable colored output. Set it to empty if your terminal does not
# support colors.
if not set -q fish_command_timer_color
  set -g fish_command_timer_color blue
end
# Similarly, the color to use for displaying success and failure exit statuses.
if not set -q fish_command_timer_success_color
  set -g fish_command_timer_success_color green
end
if not set -q fish_command_timer_fail_color
  set -g fish_command_timer_fail_color $fish_color_status
end

# The display format of the current time.
#
# This is a strftime format string (see http://strftime.org/). To tweak the
# display format of the current time, change the following line to your desired
# pattern.
#
# If empty, disables printing of current time.
if not set -q fish_command_timer_time_format
  set -g fish_command_timer_time_format '%b %d %I:%M%p'
end

# Whether to print command timings up to millisecond precision.
#
# If set to 0, will print up to seconds precision.
if not set -q fish_command_timer_millis
  set -g fish_command_timer_millis 1
end

# Whether to export the duration string as a shell variable.
#
# When set, this will export the duration string as an environment variable
# called $CMD_DURATION_STR.
if not set -q fish_command_timer_export_cmd_duration_str
  set -g fish_command_timer_export_cmd_duration_str 1
end
if begin
     set -q fish_command_timer_export_cmd_duration_str; and \
     [ "$fish_command_timer_export_cmd_duration_str" -ne 0 ]
   end
  set -g CMD_DURATION_STR
end

# The minimum command duration that should trigger printing of command timings,
# in milliseconds.
#
# When set to a non-zero value, commands that finished within the specified
# number of milliseconds will not trigger printing of command timings.
if not set -q fish_command_timer_min_cmd_duration
  set -g fish_command_timer_min_cmd_duration 0
end


# The fish_postexec event is fired after executing a command line.
function fish_command_timer_postexec -e fish_postexec
  fish_command_timer_handle_postexec
end


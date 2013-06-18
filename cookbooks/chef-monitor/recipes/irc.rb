#
# Cookbook Name:: chef-monitor
# Recipe:: irc
#
# Copyright 2012, Stephen Lum
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "chef-monitor::default"

sensu_gem "carrier-pigeon"

cookbook_file "/etc/sensu/handlers/irc.rb" do
  source "handlers/irc.rb"
  mode 0755
end

sensu_handler "irc" do
  type "pipe"
  command "irc.rb"
end

sensu_snippet "irc" do
  content({:irc_server => "#{node[:irc_url]}", :irc_password => "#{node[:irc_password]}"})
end
#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#
# Copyright 2013, Openhood S.E.N.C.
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

include_recipe "git"

if Chef::Config[:solo] and not node.run_list?("recipe[chef-solo-search]")
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search unless you install the chef-solo-search cookbook.")
else
  search(:users, "shell:*zsh AND oh-my-zsh_enabled:true").each do |u|
    home = u["home"] || "/home/#{u["username"] || u["id"]}"
    repository = u["oh-my-zsh"]["repository"] || node["oh-my-zsh"]["repository"]
    branch = u["oh-my-zsh"]["branch"] || node["oh-my-zsh"]["branch"]
    update_strategy = u["oh-my-zsh"]["update_strategy"] || node["oh-my-zsh"]["update_strategy"]

    git "#{home}/.oh-my-zsh" do
      user u["id"]
      group u["gid"]
      repository repository
      reference branch
      action update_strategy
    end

    zshrc_vars = {}
    node["oh-my-zsh"]["options"].each do |key, value|
      user_value = u["oh-my-zsh"]["options"][key] if u["oh-my-zsh"]["options"]
      zshrc_vars[key] = user_value || value
    end

    template "#{home}/.zshrc" do
      source "zshrc.erb"
      owner u["id"]
      group u["gid"]
      mode 0644
      variables zshrc_vars
    end
  end
end

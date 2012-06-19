#
# Cookbook Name:: users
# Recipe:: clean
#
# Copyright 2011, Atalanta Systems Ltd
#
# All rights reserved - Do Not Redistribute
#
# Recipe that cleans old users from system.

# Create token group if not exist
if not node[:etc][:group].include?(node[:users][:token_group])
  group "#{node[:users][:token_group]}" do
    action :create
  end
end

# Add users from 'users' databag to token_group. if they're exist in system.

search(:users, '*:*') do |u|
  # Check that user exist
  if node[:etc][:passwd].include?(u['id'])
    # if user from 'users' databag exist - add it to token_group 
    group "#{node[:users][:token_group]}" do
      action :manage
      append true
      members u['id']
    end
  end
end

# Delete users that in token_group, but not in 'users' databag.
# Create list of 

users = data_bag('users')
##users.each do |user|
##end

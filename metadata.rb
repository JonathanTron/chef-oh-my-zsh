name             "oh-my-zsh"
maintainer       "Openhood S.E.N.C"
maintainer_email "jonathan@openhood.com"
license          "Apache 2.0"
description      "Installs/Configures oh-my-zsh"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

%w( ubuntu debian centos redhat fedora).each do |os|
  supports os
end

depends "git"

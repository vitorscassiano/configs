require 'pry'

def install_java
  sh 'add-apt-repository ppa:webupd8team/java'
  sh 'apt-get update'
  sh 'apt-get install oracle-java8-installer'
  sh 'echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections'
  sh 'update-java-alternatives -s java-8-oracle'
end

SCRIPT_DIR = 'scripts'
TEMPLATE_DIR = 'templates'

namespace 'config' do
  desc ''
  task :bashrc do
    sh("cp #{TEMPLATE_DIR}/.bashrc ~/")
  end
  desc 'Adding common vimrc tricks'
  task :vimrc do
    sh("cp #{TEMPLATE_DIR}/.vimrc ~/")
  end
  desc 'Adding bash colorful'
  task :bashcolors do
    sh("cp #{TEMPLATE_DIR}/.bashcolors ~/")
  end
  desc 'Provides IntelliJ for ubuntu easier'
  task :ubuntu_install_intelliJ => :ubuntu_install_java do
    sh 'wget -O /tmp/intellij.tar.gz http://download.jetbrains.com/idea/ideaIC-12.0.4.tar.gz'
    sh 'tar xfz /tmp/intellij.tar.gz'
    sh 'cd idea-IC-123.169/bin'
    sh './idea.sh'
    sh 'cp ../  /usr/share/applications/IDEA.desktop '
  end
  desc 'Adding some alias and configurations to your gitconfig'
  task :gitconfig do
    sh("cp #{TEMPLATE_DIR}/.gitconfig ~/")
  end
  desc 'Install Java-8 on Ubuntu'
  task :ubuntu_install_java do
    binding.pry
    if (!sh('which /usr/bin/java'))
      install_java
    else
      puts 'You already have java, do you want to continue and overwrite it? (Y / N)'
      choice = gets.chomp!
      if (choice.upcase == 'Y')
        install_java
      end
    end
  end
end

task :default => [] 

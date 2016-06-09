# encoding: utf-8 

Redmine::Plugin.register :weeklyreport do
  name 'Weeklyreport plugin'
  author 'qian chen jie '
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://github.com/kexun'
  
  project_module :weeklyreport do
    permission :weeklyreport, :weeklyreports => :index
  end
  
  menu :project_menu, :weeklyreport, { :controller => 'weeklyreports', :action => 'index' }, :caption => :my_label2, :after => :settings, :param => :project_id
end

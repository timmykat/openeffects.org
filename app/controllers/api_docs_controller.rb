# See http://andowebsit.es/blog/noteslog.com/post/how-to-run-rake-tasks-programmatically/
# require 'rake'
# load File.join(Rails.root, 'lib', 'tasks', 'ofx.rake')
class ApiDocsController < ApplicationController
  def update
    if params[:release].blank?
      respond_to { |format| format.json { render :json => { error: 'Please specify a release' }}}
    end
    %x( bundle exec rake "ofx:update_docs[#{params['release']}]" )
    respond_to {|format| format.json { render :json => { :data => 'Done' }}}
  end
  
  def insert_nav  
    %x( bundle exec rake 'ofx:prep_docs' )  
    respond_to { |format| format.json { render :json => { :data => 'Done' }}}
  end
  
  private
    require 'stringio'
    def capture_stdout
      begin
        save_stdout = $stdout
        $stdout = StringIO.new
        yield
        $stdout.string
      ensure
        $stdout = save_stdout
      end
    end
end
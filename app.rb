# coding: utf-8
require 'bundler'
Bundler.require

require 'sinatra'
require 'json'

Dotenv.load!

DB = Sequel.connect(ENV['DBURL'])
Sequel::Model.plugin :timestamps

class CspReport < Sequel::Model
end

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', ENV['ADMIN_PASSWORD']]
  end
end

get '/.csp-reports' do
  protected!
  
  @reports = CspReport.all
  erb :index
end

post '/.csp-reports' do
  params = (JSON.parse request.body.read)['csp-report']
  report = CspReport.find_or_create(document_uri: params['document-uri'],
                                    blocked_uri: params['blocked-uri'],
                                    violated_directive: params['violated-directive'],
                                    original_policy: params['original-policy']) do |r|
    r.report_count = 0
  end

  report.report_count += 1
  report.save

  [200, 'OK']
end


require 'parser'
require_relative '../spec_helper'
RSpec.describe Parser do 
  let(:file_path) { 'spec/fixtures/webserver_fixture.log' }

  subject { described_class.new(file_path) }

  let(:formated_logs) do 
    { 
      "/help_page/1"=>["126.318.035.038", "929.398.951.889", "722.247.931.582", "646.865.545.408"], 
      "/contact"=>["184.123.665.067"], 
      "/home"=>["184.123.665.067", "235.313.352.950"], 
      "/about/2"=>["444.701.448.104"], "/index"=>["444.701.448.104", "444.701.448.104"], 
      "/about"=>["061.945.150.735"]
    }
  end

  context 'Parser class Test' do    
    it 'assemble logs in hash format' do 
      expect(subject.assemble_logs).to eq formated_logs
    end

    it 'generate unique_page_views ' do
      subject.assemble_logs
      expected = {"/help_page/1"=>4, "/contact"=>1, "/home"=>2, "/about/2"=>1, "/index"=>1, "/about"=>1}
      expect(subject.generate_parsed_logs(true)).to eq expected
    end

    it 'generate most_page_views ' do
      subject.assemble_logs
      expected = {"/help_page/1"=>4, "/contact"=>1, "/home"=>2, "/about/2"=>1, "/index"=>2, "/about"=>1}
      expect(subject.generate_parsed_logs(false)).to eq expected
    end

  end
end

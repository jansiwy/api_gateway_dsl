describe APIGatewayDSL::Document do
  let(:fixtures_dir) { Pathname.new('spec/fixtures') }

  %w( greedy_http_proxy http_get lambda_post lambda_post_with_cors mock_options ).each do |fixture|
    describe "for '#{fixture}' fixture" do
      let(:fixture_dir) { fixtures_dir.join(fixture) }

      let(:from_dsl) { described_class.load(fixture_dir).as_json }
      let(:from_yml) { YAML.load_file(fixture_dir.join('index.yml')) }

      it 'includes the expected definitions' do
        expect(from_dsl).to include_json(from_yml)
      end

      it 'does not include unexptected definitions' do
        expect(from_yml).to include_json(from_dsl)
      end
    end
  end
end

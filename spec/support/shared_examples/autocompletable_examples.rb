RSpec.shared_examples :autocompletable do |field|
  describe 'autocompletion' do
    let(:model) { described_class }

    context 'elasticsearch mapping' do
      let(:mapping) { model.mapping }

      it 'is valid' do
        expect(mapping).to be_kind_of Elasticsearch::Model::Indexing::Mappings
      end

      context 'properties' do
        let(:props) do
          entity = model.to_s.downcase.to_sym

          mapping.to_hash[entity][:properties]
        end
        let(:suggest_prop) { "#{field}_suggest" }

        it 'contains appropriate suggest field' do
          expect(props).to include(suggest_prop)
        end

        it 'suggest property is completion typed' do
          suggested = props[suggest_prop]

          expect(suggested).to include(type: 'completion')
        end
      end
    end
  end
end

require 'spec_helper'

describe SerpApiCodeChallenge::ArtworkBuilder do
  subject(:builder) { described_class.new(name: name, extensions: extensions, link: link, image: image) }

  let(:name) { "The Starry Night" }
  let(:extensions) { "1889" }
  let(:link) { "/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-BYILw" }
  let(:image) { "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD////2Qx3dx3d" }

  describe '#build' do
    subject { builder.build }

    let(:expected_results) do
      { 'name' => name,
        'extensions' => extensions,
        'link' => "https://www.google.com" + link,
        'image' => image }
    end
  
    it 'builds a hash with an artwork data' do
      expect(subject).to eq(expected_results)
    end
  
    context 'when extensions are empty' do
      let(:extensions) { [] }
      let(:expected_results) do
        { 'name' => name,
          'link' => "https://www.google.com" + link,
          'image' => image }
      end
  
      it 'builds a hash without `extensions` attribute' do
        expect(subject).to eq(expected_results)
      end
    end
  
    context "when image is nil" do
      let(:image) { nil }
  
      it 'builds a hash with an empty image data' do
        expect(subject).to eq(expected_results)
      end
    end
  end
end
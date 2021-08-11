# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_file) { fixture_file_upload('valid_sample.csv', 'text/csv') }
  let(:invalid_file) { fixture_file_upload('invalid_sample.csv', 'text/csv') }
  let(:invalid_mime_type) { fixture_file_upload('invalid_mime.txt', 'text') }
  let(:extra_info_file) { fixture_file_upload('extra_info_file.csv', 'text/csv') }
  let(:wrong_file) { fixture_file_upload('users.csv', 'text/csv') }

  describe 'POST#create: Upload CSV and create users' do
    context 'when processing without file' do
      before { post :create }
      it 'should show error message' do
        expect(flash[:error]).to be_present
        expect(flash[:error]).to match(/Please select a file/)
      end
    end

    context 'when processing with wrong mime type file' do
      before { post :create, params: { file: invalid_mime_type } }
      it 'should show error message' do
        expect(flash[:error]).to be_present
        expect(flash[:error]).to match(/Please select file with CSV format/)
      end
    end

    context 'when processing with wrong headers' do
      before { post :create, params: { file: extra_info_file } }
      it 'should show error message' do
        expect(flash[:error]).to be_present
        expect(flash[:error]).to match(/Invalid Headers. Please refer Sample CSV./)
      end
    end

    context 'when processing with wrong csv file' do
      before { post :create, params: { file: wrong_file } }
      it 'should show error message' do
        expect(flash[:error]).to be_present
        expect(flash[:error]).to match(/Invalid CSV format. Please refer Sample CSV./)
      end
    end

    context 'when processing with csv file' do
      context 'with valid data' do
        before { post :create, params: { file: valid_file } }
        it 'should create users' do
          expect(response.status).to eql(200)
          expect(User.count).to eql(1)
          expect(flash[:notice]).to match(/CSV processing successfully/)
        end
      end

      context 'with in-valid data' do
        before { post :create, params: { file: invalid_file } }
        it 'should not create users' do
          expect(User.count).to eql(0)
        end
      end
    end
  end

  describe 'get#sample_csv: Download sample_csv' do
    before { get :sample_csv, format: :csv }
    it 'should create a sample csv' do
      expect(response.header['Content-Type']).to include 'text/csv'
    end
  end
end

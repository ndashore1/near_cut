# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/upload', type: :view do
  context 'When user creates successfully' do
    before(:each) do
      User.new(name: 'Muhammad', password: 'QPFJWz1343439').save
      assign(:results, [
               'Muhammad was successfully saved.'
             ])
    end

    it 'renders text' do
      render
      assert_select '.user-header>h2', text: 'CSV Uploader'.to_s
      assert_select '.user-results>ol>li', text: 'Muhammad was successfully saved.'.to_s
    end
  end

  context 'when user does not create' do
    before(:each) do
      user = User.new(name: 'Axel', password: '')
      user.save
      assign(:results, [
               user.errors.full_messages.join(', ')
             ])
    end

    it 'renders text' do
      render
      assert_select '.user-header>h2', text: 'CSV Uploader'.to_s
      assert_select '.user-results>ol>li',
                    text: "Axel's Password can't be blank".to_s
    end
  end
end

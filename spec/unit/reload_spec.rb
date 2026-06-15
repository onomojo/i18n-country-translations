# frozen_string_literal: true

require "spec_helper"

describe "surviving an I18n reload" do
  it "keeps country translations after a development reload cycle" do
    expect(I18n.t(:FR, scope: :countries, locale: :fr)).to eql "France"

    I18n.reload!
    Rails.application.reloader.prepare!

    expect(I18n.t(:FR, scope: :countries, locale: :fr)).to eql "France"
  end
end

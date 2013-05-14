require File.expand_path('../support/helpers', __FILE__)

describe 'oh-my-zsh::default' do

  include Helpers::OhMyZsh

  let(:oh_my_zsh) { file("#{home}/.oh-my-zsh") }
  let(:zshrc) { file("#{home}/.zshrc") }

  describe "users without zsh shell" do
    let(:home) { "/home/user_without_zsh" }

    it "don't have .oh-my-zsh" do
      oh_my_zsh.wont_exist
    end

    it "don't have .zshrc" do
      zshrc.wont_exist
    end
  end

  describe "users with zsh shell but oh-my-zsh not enabled" do
    let(:home) { "/home/user_without_oh_my_zsh" }

    it "don't have .oh-my-zsh" do
      oh_my_zsh.wont_exist
    end

    it "don't have .zshrc" do
      zshrc.wont_exist
    end
  end

  describe "users with zsh shell and oh-my-zsh enabled" do
    let(:home) { "/home/user_with_oh_my_zsh" }

    it "has .oh-my-zsh" do
      oh_my_zsh.must_exist
    end

    describe ".zshrc" do

      it "exists" do
        zshrc.must_exist
      end

    end

  end
end

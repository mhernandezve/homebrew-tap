class Herdinator < Formula
  desc "A tmuxinator-compatible project manager for named Herdr workspaces"
  homepage "https://github.com/mhernandezve/herdinator"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mhernandezve/herdinator/releases/download/v0.2.0/herdinator-aarch64-apple-darwin.tar.xz"
      sha256 "472a9de4f79207f482791dc813fc4888dad040b0692585f3fe0182b647864e7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mhernandezve/herdinator/releases/download/v0.2.0/herdinator-x86_64-apple-darwin.tar.xz"
      sha256 "463bf6d86a18a1211cddb1c35a0724528322e449953e920f29cd45f01007b9fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mhernandezve/herdinator/releases/download/v0.2.0/herdinator-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d8c6ee6c55eac38a0a9b9942fa4780454767887b23c1a744c34e650e1146af66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mhernandezve/herdinator/releases/download/v0.2.0/herdinator-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d4077b5678586ab5701b51a5ed1794825ad7522b566784ef6c02f83a58ce37d"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "herdinator"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "herdinator"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "herdinator"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "herdinator"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

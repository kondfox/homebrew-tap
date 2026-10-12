class Pmx < Formula
  desc "Engineering metrics from git history, with a web dashboard"
  homepage "https://github.com/kondfox/project-metrics"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kondfox/project-metrics/releases/download/v0.1.0/pmx-aarch64-apple-darwin.tar.xz"
      sha256 "8bfa0e8d9a8f488d382d6612035b11755b8b16d55f2c2c5d5eb6e99bfe1519f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kondfox/project-metrics/releases/download/v0.1.0/pmx-x86_64-apple-darwin.tar.xz"
      sha256 "6cd39ffef25ca9d5a28514d96146a0931194cffca3134b2809a0055375fd8e07"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kondfox/project-metrics/releases/download/v0.1.0/pmx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5b6f7fe683cf08ebc91a84601d7e05ae7179342b8c682318e7efe0bc531d060c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kondfox/project-metrics/releases/download/v0.1.0/pmx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dec401c5094c5f104fa59202c2a242bae828e3d18155b425847388346051593a"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "pmx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pmx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pmx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pmx"
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

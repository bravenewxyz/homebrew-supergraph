class Supergraph < Formula
  desc "Unified code analysis toolkit — semantic graphs, complexity, dead exports, contracts, and more"
  homepage "https://github.com/bravenewxyz/supergraph"
  version "1.0.3"

  on_macos do
    on_arm do
      url "https://github.com/bravenewxyz/supergraph/releases/download/v#{version}/supergraph-darwin-arm64.tar.gz"
      sha256 "a03e881197f2c0daf7926e8e8677e5afc39aa5129c723fc1d7e312e9b4396d96"
    end

    on_intel do
      url "https://github.com/bravenewxyz/supergraph/releases/download/v#{version}/supergraph-darwin-x64.tar.gz"
      sha256 "45fd81b2eddf1d4415db12796052f80b037b6e9afa825a296f61eeac545027d4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bravenewxyz/supergraph/releases/download/v#{version}/supergraph-linux-x64.tar.gz"
      sha256 "92b7b709a7699aff706e0c14cf70ca56c75657e802aa0748b22e225522889dba"
    end
  end

  def install
    bin.install "supergraph"
  end

  def post_install
    claude_cmd_dir = Pathname.new(Dir.home)/".claude"/"commands"
    claude_cmd_dir.mkpath
    dest = claude_cmd_dir/"deep-audit.md"
    url = "https://raw.githubusercontent.com/bravenewxyz/supergraph/master/commands/deep-audit.md"
    system "curl", "-fsSL", url, "-o", dest.to_s

    supergraph_dir = Pathname.new(Dir.home)/".supergraph"
    supergraph_dir.mkpath
    (supergraph_dir/".setup-done").write(Time.now.utc.iso8601)
  end

  def caveats
    <<~EOS
      The /deep-audit command for Claude Code has been installed to:
        ~/.claude/commands/deep-audit.md
    EOS
  end

  test do
    assert_match "supergraph", shell_output("#{bin}/supergraph --help")
  end
end

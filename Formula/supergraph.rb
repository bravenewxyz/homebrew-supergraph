class Supergraph < Formula
  desc "Unified code analysis toolkit — semantic graphs, complexity, dead exports, contracts, and more"
  homepage "https://github.com/bravenewxyz/supergraph"
  version "1.0.13"

  on_macos do
    on_arm do
      url "https://github.com/bravenewxyz/supergraph/releases/download/v#{version}/supergraph-darwin-arm64.tar.gz"
      sha256 "9eaa983f10af40de63eb41c79dcfe9d674c3f0910e5a1bd110e159085dac65e9"
    end

    on_intel do
      url "https://github.com/bravenewxyz/supergraph/releases/download/v#{version}/supergraph-darwin-x64.tar.gz"
      sha256 "a1a114a482af8123d5bbae95255e67e7977faed5f1fb41533df8ebe694add072"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bravenewxyz/supergraph/releases/download/v#{version}/supergraph-linux-x64.tar.gz"
      sha256 "869a907664fb1150744496b092eda09c4384e7cf7bb7faa37fac59fa72b68de2"
    end
  end

  def install
    bin.install "supergraph"
    (libexec/"lib").install Dir["lib/*"]
  end

  def post_install
    claude_cmd_dir = Pathname.new(Dir.home)/".claude"/"commands"
    claude_cmd_dir.mkpath
    base_url = "https://raw.githubusercontent.com/bravenewxyz/supergraph/master/commands"
    %w[deep-audit.md high-level.md init-supergraph.md].each do |cmd|
      system "curl", "-fsSL", "#{base_url}/#{cmd}", "-o", (claude_cmd_dir/cmd).to_s
    end

    supergraph_dir = Pathname.new(Dir.home)/".supergraph"
    supergraph_dir.mkpath
    (supergraph_dir/".setup-done").write(Time.now.utc.iso8601)
  end

  def caveats
    <<~EOS
      Claude Code commands installed to ~/.claude/commands/:
        /deep-audit  /high-level  /init-supergraph
    EOS
  end

  test do
    assert_match "supergraph", shell_output("#{bin}/supergraph --help")
  end
end

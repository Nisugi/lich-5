# frozen_string_literal: true

require_relative '../../spec_helper'

# The ;ui handshake reply is a machine-readable <LichWebUI .../> line that
# frontends parse from the game stream. It MUST be sent via _respond:
# respond() XML-escapes output for mono-capable frontends (Wrayth, VellumFE),
# which turns the tag into &lt;...&gt; display text that no parser ever sees.
#
# This regressed once when a repo sync overwrote the fix, silently breaking
# every native-embedding frontend. The command dispatch lives in the huge
# global_defs.rb, so this guard pins the source line itself.
RSpec.describe 'WebUI handshake delivery' do
  it 'sends the handshake payload raw via _respond, never respond' do
    source = File.read(File.expand_path('../../../lib/global_defs.rb', __dir__))
    handshake_lines = source.lines.select { |line| line.include?('Lich::WebUI.handshake_payload') }
    expect(handshake_lines).not_to be_empty, 'handshake dispatch not found in global_defs.rb'
    handshake_lines.each do |line|
      expect(line).to match(/_respond\(/),
                      "handshake must use _respond (respond XML-escapes the tag): #{line.strip}"
      expect(line).not_to match(/[^_]respond\(/)
    end
  end
end

(function(Scratch) {
  'use strict';

  if (!Scratch.extensions.unsandboxed) {
    throw new Error('This extension must be run unsandboxed');
  }

  // Load crypto-js dynamically
  const script = document.createElement('script');
  script.src = 'https://cdn.jsdelivr.net/npm/crypto-js@4.1.1/crypto-js.min.js';
  document.head.appendChild(script);

  class SHA256Extension {
    getInfo() {
      return {
        id: 'sha256',
        name: 'SHA-256',
        blocks: [
          {
            opcode: 'hash',
            blockType: Scratch.BlockType.REPORTER,
            text: 'SHA-256 of [TEXT]',
            arguments: {
              TEXT: {
                type: Scratch.ArgumentType.STRING,
                defaultValue: 'hello world'
              }
            }
          }
        ]
      };
    }

    hash(args) {
      if (typeof CryptoJS === 'undefined') {
        return 'Loading...';
      }
      const input = args.TEXT || '';
      return CryptoJS.SHA256(input).toString();
    }
  }

  Scratch.extensions.register(new SHA256Extension());
})(Scratch);

using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Audio.Decoder.RNAudioDecoder
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNAudioDecoderModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNAudioDecoderModule"/>.
        /// </summary>
        internal RNAudioDecoderModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNAudioDecoder";
            }
        }
    }
}

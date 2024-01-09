using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Considerate.Service.To.Custom.RNConsiderateServiceToCustom
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNConsiderateServiceToCustomModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNConsiderateServiceToCustomModule"/>.
        /// </summary>
        internal RNConsiderateServiceToCustomModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNConsiderateServiceToCustom";
            }
        }
    }
}

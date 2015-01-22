DerelictCEF
==========

A dynamic binding to the [Chromium Embedded Framework][1] for the D Programming Language.

Please see the pages [Building and Linking Derelict][2] and [Using Derelict][2], in the Derelict documentation, for information on how to build DerelictCEF and load libcef at run time. In the meantime, here's some sample code.

```D
import derelict.cef.cef;

void main() {
    // Load the CEF library.
    DerelictCEF.load();

    // Now libcef functions can be called.
    ...
}
```
[1]: http://derelictorg.github.io/compiling.html
[2]: https://code.google.com/p/chromiumembedded/
[3]: https://github.com/DerelictOrg/DerelictUtil/wiki/DerelictUtil-for-Users

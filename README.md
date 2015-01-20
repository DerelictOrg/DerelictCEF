DerelictVorbis
==========

A dynamic binding to [libvorbis][1] for the D Programming Language.

For information on how to build DerelictVorbis and link it with your programs, please see the post [Using Derelict][2] at The One With D.

For information on how to load the libvorbis library via DerelictVorbis, see the page [DerelictUtil for Users][2] at the DerelictUtil Wiki. In the meantime, here's some sample code.

```D
import derelict.vorbis.vorbis;
import derelict.vorbis.enc;
import derelict.vorbis.file;

void main() {
    // Load the libvorbis library and it's companing encoding and file libaries.
    DerelictVorbis.load();
    DerelictVorbisEnc.load();
    DerelictVorbisFile.load();

    // Now libvorbis functions can be called.
    ...
}
```

[1]: http://xiph.org/vorbis/
[2]: http://dblog.aldacron.net/derelict-help/using-derelict/
[3]: https://github.com/DerelictOrg/DerelictUtil/wiki/DerelictUtil-for-Users

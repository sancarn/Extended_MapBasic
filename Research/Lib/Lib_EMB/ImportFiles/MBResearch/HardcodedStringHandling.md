# Which characters can a hard coded string detect?

```
Print chr$(12)
Dim s as string,i as integer
s = "	 !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
For i = 0 to len(s)
	print asc(mid$(s,i,1))
Next
```

Take note the above example. we define a string containing all characters from 0 to 255 except chars 00, 10, 11, 13. This is because `Chr$(0)` makes the MapBasic editor 'see' the end of the file prematurely and characters 10, 11 and 12 stop the MBEditor parsing the string, since strings `have to be defined on 1 line`. It's also worth noting that all `"` characters have to be escaped with `""`.

All characters print, as desired, which brings some extremely useful knowledge to the table when wanting to store binary files.

Given that characters 0, 10, 11, 13 can be written as: `chr$(0)` , `chr$(10)` , `chr$(11)` , `chr$(13)` it may be better to store files in this raw binary format as then we can store the maximum file size of 32767 bytes per string, instead of the formerly assumed 16383 bytes of data.

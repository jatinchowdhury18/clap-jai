#import "Basic";

strlen :: (s: *u8) -> s64 {  // Return the length of s, a C-style zero-terminated string.
    // If you pass in a pointer that is not zero-terminated,
    // BAD things will happen!
    count: s64 = 0;

    while <<s {
        count += 1;
        s += 1;
    }

    return count;
}

to_string :: (s: *u8) -> string { // converts a c-string to a jai string. Make sure the c-string memory outlives the jai string!
    str: string;
    str.data = s;
    str.count = strlen(s);
    return str;
}

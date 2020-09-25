#import <UIKit/UIPasteboard.h>

int main(int argc, char **argv, char **envp) {
	if (argc != 2) {
		fprintf(stderr, 
			"Usage: %s [string]\n"
			"Description: Copies given string to the clipboard\n"
			, argv[0]
		);
		return 0;
	}
	UIPasteboard *board = [UIPasteboard generalPasteboard];
	[board setString:@(argv[1])];
	return 0;
}

// vim:ft=objc

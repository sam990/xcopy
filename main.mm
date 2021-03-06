#import <UIKit/UIPasteboard.h>

#include <getopt.h>

#define BUF_SIZ 4096

void printHelp(int argc, char **argv) {
	fprintf(stderr, 
			"\nUsage: %s [OPTION]... [string]...\n\n"
			"Description: Copies given string to the clipboard\n"
			"If string is not given, program reads from stdin, until EOF is reached.\n\n"
			"Options: \n"
			"  -h,--help      Print this help\n"
			"  -p,--paste     Write the contents of clipboard to stdout\n\n"
			, argv[0]
	);
}

void clipboardPaste() {
	UIPasteboard *board = [UIPasteboard generalPasteboard];
	fprintf(stdout, "%s\n\n", [board.string UTF8String]);
}


int main(int argc, char **argv, char **envp) {
	struct option long_options[] = {
		{"paste", no_argument, NULL, 'p'},
		{"help", no_argument, NULL, 'h'},
		{0, 0, 0, 0}
	};

	int opt, opt_index = 0;

	while ((opt = getopt_long(argc, argv, "hp", long_options, &opt_index)) != -1) {
		if (opt == 'p') {
			clipboardPaste();
			return 0;
		}
		printHelp(argc, argv);
		return 0;
	}

	// the final string pointer
	char *target;;

	if (argc == 1) {
		// print help
		fprintf(stdout, 
			"Enter text. Enter EOF (Ctrl-D) to complete\n\n"
		);

		// read from stdin
		char buffer[BUF_SIZ];
		int i = 0;
		int ch;
		while (i < (BUF_SIZ - 1) && (ch = fgetc(stdin)) != EOF) {
			buffer[i++] = (char)ch;
		}
		buffer[i] = '\0';
		target = buffer;
	} else {
		target = argv[1];
	}

	UIPasteboard *board = [UIPasteboard generalPasteboard];
	[board setString:@(target)];
	return 0;
}

// vim:ft=objc

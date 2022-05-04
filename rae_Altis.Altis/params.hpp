class Params
{
	class spacer0 {
		title = "- Debug Settings -";
		values[] = {""};
		texts[] = {""};
		default = "";
	};
	class raeDebug {
		title = "Debug";
		texts[] = {"Off","On"};
		values[] = {0,1};
		default = 1; //1 For development
	};

	class spacer1 {
		title = "- Mission Settings -"
		texts[] = {""};
		values[] = {""};
		default = "";
	};
	class raeMaxRange {
		title = "Max range to spawn missions within"
		texts[] = {"Entire Map", "4kms", "6kms", "8kms", "10kms"};
		values[] = {0, 4, 6, 8, 10};
		default = 0; //0 = Entire Map .. Don't ask
	};
};
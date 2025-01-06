# Import the module
using module InteractiveMenu

# Define the items for the menu
# Note: the url and info are optional
$menuItems = @(
    [InteractiveMultiMenuItem]::new("option1", "First Option", $true, 0, $false, "First option info", "https://example.com/")
    [InteractiveMultiMenuItem]::new("Option 2", "Second Option", $true, 1, $false, "Second option info", "https://example.com/")
)

# Define the header of the menu
$header = "Choose your options"

# Instantiate new menu object
$menu = [InteractiveMultiMenu]::new($header, $menuItems);

# [Optional] You can change the colors and the symbols
$options = @{
    HeaderColor = [ConsoleColor]::Magenta;
    HelpColor = [ConsoleColor]::Cyan;
    CurrentItemColor = [ConsoleColor]::DarkGreen;
    LinkColor = [ConsoleColor]::DarkCyan;
    CurrentItemLinkColor = [ConsoleColor]::Black;
    MenuDeselected = "[ ]";
    MenuSelected = "[x]";
    MenuCannotSelect = "[/]";
    MenuCannotDeselect = "[!]";
    MenuInfoColor = [ConsoleColor]::DarkYellow;
    MenuErrorColor = [ConsoleColor]::DarkRed;
}
$menu.SetOptions($options)

# Trigger the menu and receive the user selections
$selectedItems = $menu.GetSelections()

foreach ($item in $selectedItems) {
    Write-Host $item
}


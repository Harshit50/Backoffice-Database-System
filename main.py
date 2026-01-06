
"""
Main entry point for the Back Office Database Application
"""
import sys
from ui.connect_window import ConnectWindow

def main():
    """Launch the application"""
    app = ConnectWindow()
    app.run()

if __name__ == "__main__":
    main()
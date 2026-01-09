"""
Database Connection Window UI
"""
import tkinter as tk
from tkinter import ttk, messagebox
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from database.db_connection import db_instance

class ConnectWindow:
    """Database connection window"""
    
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Connect to Back Office Database")
        self.root.geometry("600x450")
        self.root.resizable(False, False)
        
        # Center the window
        self.center_window()
        
        # Create UI elements
        self.create_widgets()
        
        # Set default values for testing
        self.set_default_values()
        
    def center_window(self):
        """Center the window on screen"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')
    
    def create_widgets(self):
        """Create and layout UI elements"""
        # Main container frame with rounded appearance
        main_frame = tk.Frame(self.root, bg='white')
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)
        
        # Title
        title_label = tk.Label(
            main_frame,
            text="Connect to Back Office Database",
            font=('Arial', 16, 'bold'),
            bg='white'
        )
        title_label.pack(pady=(20, 30))
        
        # Connection form frame
        form_frame = tk.Frame(main_frame, bg='lightgray', relief=tk.RIDGE, borderwidth=2)
        form_frame.pack(fill=tk.BOTH, expand=True, padx=40, pady=(0, 20))
        
        # Inner padding frame
        inner_frame = tk.Frame(form_frame, bg='lightgray')
        inner_frame.pack(fill=tk.BOTH, expand=True, padx=40, pady=40)
        
        # Host and Port row
        host_port_frame = tk.Frame(inner_frame, bg='lightgray')
        host_port_frame.pack(fill=tk.X, pady=(0, 20))
        
        tk.Label(host_port_frame, text="Host", bg='lightgray', font=('Arial', 10)).pack(side=tk.LEFT, padx=(0, 10))
        self.host_entry = tk.Entry(host_port_frame, width=25, font=('Arial', 10))
        self.host_entry.pack(side=tk.LEFT, padx=(0, 30))
        
        tk.Label(host_port_frame, text="Port", bg='lightgray', font=('Arial', 10)).pack(side=tk.LEFT, padx=(0, 10))
        self.port_entry = tk.Entry(host_port_frame, width=10, font=('Arial', 10))
        self.port_entry.pack(side=tk.LEFT)
        
        # Database row
        db_frame = tk.Frame(inner_frame, bg='lightgray')
        db_frame.pack(fill=tk.X, pady=(0, 20))
        
        tk.Label(db_frame, text="Database", bg='lightgray', font=('Arial', 10)).grid(row=0, column=0, sticky='w', padx=(0, 10))
        self.database_entry = tk.Entry(db_frame, width=45, font=('Arial', 10))
        self.database_entry.grid(row=0, column=1, sticky='w')
        
        # Username row
        user_frame = tk.Frame(inner_frame, bg='lightgray')
        user_frame.pack(fill=tk.X, pady=(0, 20))
        
        tk.Label(user_frame, text="Username", bg='lightgray', font=('Arial', 10)).grid(row=0, column=0, sticky='w', padx=(0, 10))
        self.username_entry = tk.Entry(user_frame, width=45, font=('Arial', 10))
        self.username_entry.grid(row=0, column=1, sticky='w')
        
        # Password row
        pwd_frame = tk.Frame(inner_frame, bg='lightgray')
        pwd_frame.pack(fill=tk.X, pady=(0, 20))
        
        tk.Label(pwd_frame, text="Password", bg='lightgray', font=('Arial', 10)).grid(row=0, column=0, sticky='w', padx=(0, 10))
        self.password_entry = tk.Entry(pwd_frame, width=45, show='*', font=('Arial', 10))
        self.password_entry.grid(row=0, column=1, sticky='w')
        
        # Buttons
        button_frame = tk.Frame(inner_frame, bg='lightgray')
        button_frame.pack(pady=(20, 0))
        
        self.connect_button = tk.Button(
            button_frame,
            text="Connect",
            command=self.handle_connect,
            width=12,
            font=('Arial', 10)
        )
        self.connect_button.pack(side=tk.LEFT, padx=10)
        
        exit_button = tk.Button(
            button_frame,
            text="Exit",
            command=self.handle_exit,
            width=12,
            font=('Arial', 10)
        )
        exit_button.pack(side=tk.LEFT, padx=10)
        
        # Bind Enter key to connect
        self.root.bind('<Return>', lambda event: self.handle_connect())
        
    def set_default_values(self):
        """Set default connection values for testing"""
        self.host_entry.insert(0, "localhost")
        self.port_entry.insert(0, "3306")
        self.database_entry.insert(0, "backoffice")
        # Leave username and password empty for security
    
    def validate_inputs(self):
        """Validate form inputs"""
        if not self.host_entry.get().strip():
            messagebox.showerror("Validation Error", "Please enter the host address")
            self.host_entry.focus()
            return False
        
        if not self.port_entry.get().strip():
            messagebox.showerror("Validation Error", "Please enter the port number")
            self.port_entry.focus()
            return False
        
        try:
            port = int(self.port_entry.get())
            if port < 1 or port > 65535:
                raise ValueError
        except ValueError:
            messagebox.showerror("Validation Error", "Please enter a valid port number (1-65535)")
            self.port_entry.focus()
            return False
        
        if not self.database_entry.get().strip():
            messagebox.showerror("Validation Error", "Please enter the database name")
            self.database_entry.focus()
            return False
        
        if not self.username_entry.get().strip():
            messagebox.showerror("Validation Error", "Please enter the username")
            self.username_entry.focus()
            return False
        
        return True
    
    def handle_connect(self):
        """Handle connect button click"""
        if not self.validate_inputs():
            return
        
        # Disable button during connection attempt
        self.connect_button.config(state='disabled', text='Connecting...')
        self.root.update()
        
        # Attempt database connection
        success, message = db_instance.connect(
            host=self.host_entry.get().strip(),
            port=int(self.port_entry.get().strip()),
            database=self.database_entry.get().strip(),
            username=self.username_entry.get().strip(),
            password=self.password_entry.get()
        )
        
        if success:
            # Close current window and open login window
            self.root.destroy()
            from ui.login_window import LoginWindow
            login = LoginWindow()
            login.run()
        else:
            # Show error and re-enable button
            messagebox.showerror("Connection Failed", f"Unable to connect to the database server.\n\n{message}")
            self.connect_button.config(state='normal', text='Connect')
    
    def handle_exit(self):
        """Handle exit button click"""
        if messagebox.askokcancel("Exit", "Are you sure you want to exit?"):
            self.root.destroy()
            sys.exit(0)
    
    def run(self):
        """Start the window main loop"""
        self.root.mainloop()
module derelict.cef.types;

private {
    import core.stdc.stddef;
    import derelict.util.system;
}

// cef_string_*.h
alias void* cef_string_list_t;
alias void* cef_string_map_t;
alias void* cef_string_multimap_t;

struct cef_string_wide_t {
    wchar_t* str;
    size_t length;
    extern( C ) @nogc nothrow void function( wchar* ) dtor;
}

struct cef_string_utf8_t {
    char* str;
    size_t length;
    extern( C ) @nogc nothrow void function( char* ) dtor;
}

struct cef_string_utf16_t {
    wchar* str;
    size_t length;
    extern( C ) @nogc nothrow void function( wchar* ) dtor;
}

alias cef_string_userfree_wide_t = cef_string_wide_t*;
alias cef_string_userfree_utf8_t = cef_string_utf8_t*;
alias cef_string_userfree_utf16_t = cef_string_utf16_t*;

version( DerelictCEF_WideStrings ) {
    alias cef_char_t = wchar_t;
    alias cef_string_t = cef_string_wide_t;
    alias cef_string_userfree_t = cef_string_userfree_wide_t;
} else version( DerelictCEF_UTF16Strings ) {
    alias cef_char_t = wchar;
    alias cef_string_t = cef_string_utf16_t;
    alias cef_string_userfree_t = cef_string_userfree_utf16_t;
} else {
    alias cef_char_t = char;
    alias cef_string_t = cef_string_utf8_t;
    alias cef_string_userfree_t = cef_string_userfree_utf8_t;
}

// cef_time.h
struct cef_time_t {
    int year;
    int month;
    int day_of_week;
    int day_of_month;
    int hour;
    int minute;
    int second;
    int millisecond;
}

// cef_types.h
alias int64 = long;
alias uint64 = ulong;
alias int32 = int;
alias uint32 = uint;
alias cef_color_t = uint32;
alias char16 = wchar;

alias cef_log_severity_t = int;
enum {
    LOGSEVERITY_DEFAULT,
    LOGSEVERITY_VERBOSE,
    LOGSEVERITY_INFO,
    LOGSEVERITY_WARNING,
    LOGSEVERITY_ERROR,
    LOGSEVERITY_ERROR_REPORT,
    LOGSEVERITY_DISABLE = 99
}

alias cef_state_t = int;
enum {
    STATE_DEFAULT = 0,
    STATE_ENABLED,
    STATE_DISABLED,
}

struct cef_settings_t {
    size_t size;
    int single_process;
    int no_sandbox;
    cef_string_t browser_subprocess_path;
    int multi_threaded_message_loop;
    int command_line_args_disabled;
    cef_string_t cache_path;
    int persist_session_cookies;
    cef_string_t user_agent;
    cef_string_t product_version;
    cef_string_t locale;
    cef_string_t log_file;
    cef_log_severity_t log_severity;
    int release_dcheck_enabled;
    cef_string_t javascript_flags;
    cef_string_t resources_dir_path;
    cef_string_t locales_dir_path;
    int pack_loading_disabled;
    int remote_debugging_port;
    int uncaught_exception_stack_size;
    int context_safety_implementation;
    int ignore_certificate_errors;
    cef_color_t backtround_color;
}

struct cef_browser_settings_t {
    size_t size;
    cef_string_t standard_font_family;
    cef_string_t fixed_font_family;
    cef_string_t serif_font_family;
    cef_string_t sans_serif_font_family;
    cef_string_t cursive_font_family;
    cef_string_t fantasy_font_family;
    int default_font_size;
    int default_fixed_font_size;
    int minimum_font_size;
    int minimum_logical_font_size;
    cef_string_t default_encoding;
    cef_state_t remote_fonts;
    cef_state_t javascript;
    cef_state_t javascript_open_windows;
    cef_state_t javascript_close_windows;
    cef_state_t javascript_access_clipboard;
    cef_state_t javascript_dom_paste;
    cef_state_t caret_browsing;
    cef_state_t java;
    cef_state_t plugins;
    cef_state_t universal_access_from_file_urls;
    cef_state_t file_access_from_file_urls;
    cef_state_t web_security;
    cef_state_t image_loading;
    cef_state_t image_shrink_standalone_to_fit;
    cef_state_t text_area_resize;
    cef_state_t tab_to_links;
    cef_state_t local_storage;
    cef_state_t databases;
    cef_state_t application_cache;
    cef_state_t webgl;
    cef_state_t accelerated_compositing;
    cef_color_t background_color;
}

struct cef_urlparts_t {
    cef_string_t spec;
    cef_string_t scheme;
    cef_string_t username;
    cef_string_t password;
    cef_string_t host;
    cef_string_t port;
    cef_string_t origin;
    cef_string_t path;
    cef_string_t query;
}

struct cef_cookie_t {
    cef_string_t name;
    cef_string_t value;
    cef_string_t domain;
    cef_string_t path;
    int secure;
    int httponly;
    cef_time_t creation;
    cef_time_t last_access;
    int has_expires;
    cef_time_t expires;
}

alias cef_termination_status_t = int;
enum {
    TS_ABNORMAL_TERMINATION,
    TS_PROCESS_WAS_KILLED,
    TS_PROCESS_CRASHED,
}

alias cef_path_key_t = int;
enum {
    PK_DIR_CURRENT,
    PK_DIR_EXE,
    PK_DIR_MODULE,
    PK_DIR_TEMP,
    PK_FILE_EXE,
    PK_FILE_MODULE,
}

alias cef_storage_type_t = int;
enum {
    ST_LOCALSTORAGE = 0,
    ST_SESSIONSTORAGE,
}

alias cef_errorcode_t = int;
enum {
    ERR_NONE = 0,
    ERR_FAILED = -2,
    ERR_ABORTED = -3,
    ERR_INVALID_ARGUMENT = -4,
    ERR_INVALID_HANDLE = -5,
    ERR_FILE_NOT_FOUND = -6,
    ERR_TIMED_OUT = -7,
    ERR_FILE_TOO_BIG = -8,
    ERR_UNEXPECTED = -9,
    ERR_ACCESS_DENIED = -10,
    ERR_NOT_IMPLEMENTED = -11,
    ERR_CONNECTION_CLOSED = -100,
    ERR_CONNECTION_RESET = -101,
    ERR_CONNECTION_REFUSED = -102,
    ERR_CONNECTION_ABORTED = -103,
    ERR_CONNECTION_FAILED = -104,
    ERR_NAME_NOT_RESOLVED = -105,
    ERR_INTERNET_DISCONNECTED = -106,
    ERR_SSL_PROTOCOL_ERROR = -107,
    ERR_ADDRESS_INVALID = -108,
    ERR_ADDRESS_UNREACHABLE = -109,
    ERR_SSL_CLIENT_AUTH_CERT_NEEDED = -110,
    ERR_TUNNEL_CONNECTION_FAILED = -111,
    ERR_NO_SSL_VERSIONS_ENABLED = -112,
    ERR_SSL_VERSION_OR_CIPHER_MISMATCH = -113,
    ERR_SSL_RENEGOTIATION_REQUESTED = -114,
    ERR_CERT_COMMON_NAME_INVALID = -200,
    ERR_CERT_DATE_INVALID = -201,
    ERR_CERT_AUTHORITY_INVALID = -202,
    ERR_CERT_CONTAINS_ERRORS = -203,
    ERR_CERT_NO_REVOCATION_MECHANISM = -204,
    ERR_CERT_UNABLE_TO_CHECK_REVOCATION = -205,
    ERR_CERT_REVOKED = -206,
    ERR_CERT_INVALID = -207,
    ERR_CERT_END = -208,
    ERR_INVALID_URL = -300,
    ERR_DISALLOWED_URL_SCHEME = -301,
    ERR_UNKNOWN_URL_SCHEME = -302,
    ERR_TOO_MANY_REDIRECTS = -310,
    ERR_UNSAFE_REDIRECT = -311,
    ERR_UNSAFE_PORT = -312,
    ERR_INVALID_RESPONSE = -320,
    ERR_INVALID_CHUNKED_ENCODING = -321,
    ERR_METHOD_NOT_SUPPORTED = -322,
    ERR_UNEXPECTED_PROXY_AUTH = -323,
    ERR_EMPTY_RESPONSE = -324,
    ERR_RESPONSE_HEADERS_TOO_BIG = -325,
    ERR_CACHE_MISS = -400,
    ERR_INSECURE_RESPONSE = -501,
}

alias cef_drag_operations_mask_t = int;
enum {
    DRAG_OPERATION_NONE = 0,
    DRAG_OPERATION_COPY = 1,
    DRAG_OPERATION_LINK = 2,
    DRAG_OPERATION_GENERIC = 4,
    DRAG_OPERATION_PRIVATE = 8,
    DRAG_OPERATION_MOVE = 16,
    DRAG_OPERATION_DELETE = 32,
    DRAG_OPERATION_EVERY = uint.max,
}

alias cef_v8_accesscontrol_t = int;
enum {
    V8_ACCESS_CONTROL_DEFAULT = 0,
    V8_ACCESS_CONTROL_ALL_CAN_READ = 1,
    V8_ACCESS_CONTROL_ALL_CAN_WRITE = 1<<1,
    V8_ACCESS_CONTROL_PROHIBITS_OVERWRITING = 1<<2
}

alias cef_v8_propertyattribute_t = int;
enum {
    V8_PROPERTY_ATTRIBUTE_NONE       = 0,
    V8_PROPERTY_ATTRIBUTE_READONLY   = 1<<0,
    V8_PROPERTY_ATTRIBUTE_DONTENUM   = 1<<1,
    V8_PROPERTY_ATTRIBUTE_DONTDELETE = 1<<2
}

alias cef_postdataelement_type_t = int;
enum {
    PDE_TYPE_EMPTY = 0,
    PDE_TYPE_BYTES,
    PDE_TYPE_FILE,
}

alias cef_resource_type_t = int;
enum {
    RT_MAIN_FRAME,
    RT_SUB_FRAME,
    RT_STYLESHEET,
    RT_SCRIPT,
    RT_IMAGE,
    RT_FONT_RESOURCE,
    RT_SUB_RESOURCE,
    RT_OBJECT,
    RT_MEDIA,
    RT_WORKER,
    RT_PREFETCH,
    RT_FAVICON,
    RT_XHR,
}

alias cef_transition_type_t = int;
enum {
    TT_LINK = 0,
    TT_EXPLICIT = 1,
    TT_AUTO_SUBFRAME = 3,
    TT_MANUAL_SUBFRAME = 4,
    TT_FORM_SUBMIT = 7,
    TT_RELOAD = 8,
    TT_SOURCE_MASK = 0xFF,
    TT_BLOCKED_FLAG = 0x00800000,
    TT_FORWARD_BACK_FLAG = 0x01000000,
    TT_CHAIN_START_FLAG = 0x10000000,
    TT_CHAIN_END_FLAG = 0x20000000,
    TT_CLIENT_REDIRECT_FLAG = 0x40000000,
    TT_SERVER_REDIRECT_FLAG = 0x80000000,
    TT_IS_REDIRECT_MASK = 0xC0000000,
    TT_QUALIFIER_MASK = 0xFFFFFF00,
}

alias cef_urlrequest_flags_t = int;
enum {
    UR_FLAG_NONE = 0,
    UR_FLAG_SKIP_CACHE = 1<<0,
    UR_FLAG_ALLOW_CACHED_CREDENTIALS = 1<<1,
    UR_FLAG_ALLOW_COOKIES = 1<<2,
    UR_FLAG_REPORT_UPLOAD_PROGRESS = 1<<3,
    UR_FLAG_REPORT_LOAD_TIMING = 1<<4,
    UR_FLAG_REPORT_RAW_HEADERS = 1<<5,
    UR_FLAG_NO_DOWNLOAD_DATA = 1<<6,
    UR_FLAG_NO_RETRY_ON_5XX = 1<<7,
}

alias cef_urlrequest_status_t = int;
enum {
    UR_UNKNOWN = 0,
    UR_SUCCESS,
    UR_IO_PENDING,
    UR_CANCELED,
    UR_FAILED,
}

struct cef_rect_t {
    int x;
    int y;
    int width;
    int height;
}

alias cef_process_id_t = int;
enum {
    PID_BROWSER,
    PID_RENDERER,
}

alias cef_thread_id_t = int;
enum {
    TID_UI,
    TID_DB,
    TID_FILE,
    TID_FILE_USER_BLOCKING,
    TID_PROCESS_LAUNCHER,
    TID_CACHE,
    TID_IO,
    TID_RENDERER,
}

alias cef_value_type_t = int;
enum {
    VTYPE_INVALID = 0,
    VTYPE_NULL,
    VTYPE_BOOL,
    VTYPE_INT,
    VTYPE_DOUBLE,
    VTYPE_STRING,
    VTYPE_BINARY,
    VTYPE_DICTIONARY,
    VTYPE_LIST,
}

alias cef_jsdialog_type_t = int;
enum {
    JSDIALOGTYPE_ALERT = 0,
    JSDIALOGTYPE_CONFIRM,
    JSDIALOGTYPE_PROMPT,
}

struct cef_screen_info_t {
    float device_scale_factor;
    int depth;
    int depth_per_component;
    int is_monochrome;
    cef_rect_t rect;
    cef_rect_t available_rect;
}

alias cef_menu_id_t = int;
enum {
  MENU_ID_BACK = 100,
  MENU_ID_FORWARD = 101,
  MENU_ID_RELOAD = 102,
  MENU_ID_RELOAD_NOCACHE = 103,
  MENU_ID_STOPLOAD = 104,
  MENU_ID_UNDO = 110,
  MENU_ID_REDO = 111,
  MENU_ID_CUT = 112,
  MENU_ID_COPY = 113,
  MENU_ID_PASTE = 114,
  MENU_ID_DELETE = 115,
  MENU_ID_SELECT_ALL = 116,
  MENU_ID_FIND = 130,
  MENU_ID_PRINT = 131,
  MENU_ID_VIEW_SOURCE = 132,
  MENU_ID_USER_FIRST = 26500,
  MENU_ID_USER_LAST = 28500,
}

alias cef_mouse_button_type_t = int;
enum {
    MBT_LEFT = 0,
    MBT_MIDDLE,
    MBT_RIGHT,
}

struct cef_mouse_event_t {
    int x;
    int y;
    uint32 modifiers;
}

alias cef_paint_element_type_t = int;
enum {
    PET_VIEW = 0,
    PET_POPUP,
}

alias cef_event_flags_t = int;
enum {
    EVENTFLAG_NONE = 0,
    EVENTFLAG_CAPS_LOCK_ON = 1<<0,
    EVENTFLAG_SHIFT_DOWN = 1<<1,
    EVENTFLAG_CONTROL_DOWN = 1<<2,
    EVENTFLAG_ALT_DOWN = 1<<3,
    EVENTFLAG_LEFT_MOUSE_BUTTON = 1<<4,
    EVENTFLAG_MIDDLE_MOUSE_BUTTON = 1<<5,
    EVENTFLAG_RIGHT_MOUSE_BUTTON = 1<<6,
    EVENTFLAG_COMMAND_DOWN = 1<<7,
    EVENTFLAG_NUM_LOCK_ON = 1<<8,
    EVENTFLAG_IS_KEY_PAD = 1<<9,
    EVENTFLAG_IS_LEFT = 1<<10,
    EVENTFLAG_IS_RIGHT = 1<<11,
}

alias cef_menu_item_type_t = int;
enum {
    MENUITEMTYPE_NONE,
    MENUITEMTYPE_COMMAND,
    MENUITEMTYPE_CHECK,
    MENUITEMTYPE_RADIO,
    MENUITEMTYPE_SEPARATOR,
    MENUITEMTYPE_SUBMENU,
}

alias cef_context_menu_type_flags_t = int;
enum {
    CM_TYPEFLAG_NONE = 0,
    CM_TYPEFLAG_PAGE = 1<<0,
    CM_TYPEFLAG_FRAME = 1<<1,
    CM_TYPEFLAG_LINK = 1<<2,
    CM_TYPEFLAG_MEDIA = 1<<3,
    CM_TYPEFLAG_SELECTION = 1<<4,
    CM_TYPEFLAG_EDITABLE = 1<<5,
}

alias cef_context_menu_media_type_t = int;
enum {
    CM_MEDIATYPE_NONE,
    CM_MEDIATYPE_IMAGE,
    CM_MEDIATYPE_VIDEO,
    CM_MEDIATYPE_AUDIO,
    CM_MEDIATYPE_FILE,
    CM_MEDIATYPE_PLUGIN,
}

alias cef_context_menu_media_state_flags_t = int;
enum {
    CM_MEDIAFLAG_NONE = 0,
    CM_MEDIAFLAG_ERROR = 1<<0,
    CM_MEDIAFLAG_PAUSED = 1<<1,
    CM_MEDIAFLAG_MUTED = 1<<2,
    CM_MEDIAFLAG_LOOP = 1<<3,
    CM_MEDIAFLAG_CAN_SAVE = 1<<4,
    CM_MEDIAFLAG_HAS_AUDIO = 1<<5,
    CM_MEDIAFLAG_HAS_VIDEO = 1<<6,
    CM_MEDIAFLAG_CONTROL_ROOT_ELEMENT = 1<<7,
    CM_MEDIAFLAG_CAN_PRINT = 1<<8,
    CM_MEDIAFLAG_CAN_ROTATE = 1<<9,
}

alias cef_context_menu_edit_state_flags_t = int;
enum {
    CM_EDITFLAG_NONE = 0,
    CM_EDITFLAG_CAN_UNDO = 1<<0,
    CM_EDITFLAG_CAN_REDO = 1<<1,
    CM_EDITFLAG_CAN_CUT = 1<<2,
    CM_EDITFLAG_CAN_COPY = 1<<3,
    CM_EDITFLAG_CAN_PASTE = 1<<4,
    CM_EDITFLAG_CAN_DELETE = 1<<5,
    CM_EDITFLAG_CAN_SELECT_ALL = 1<<6,
    CM_EDITFLAG_CAN_TRANSLATE = 1<<7,
}

alias cef_key_event_type_t = int;
enum {
    KEYEVENT_RAWKEYDOWN = 0,
    KEYEVENT_KEYDOWN,
    KEYEVENT_KEYUP,
    KEYEVENT_CHAR
}

struct cef_key_event_t {
    cef_key_event_type_t type;
    uint32 modifiers;
    int windows_key_code;
    int native_key_code;
    int is_system_key;
    char16 character;
    char16 unmodified_character;
    int focus_on_editable_field;
}

alias cef_focus_source_t = int;
enum {
    FOCUS_SOURCE_NAVIGATION = 0,
    FOCUS_SOURCE_SYSTEM,
}

alias cef_navigation_type_t = int;
enum {
    NAVIGATION_LINK_CLICKED = 0,
    NAVIGATION_FORM_SUBMITTED,
    NAVIGATION_BACK_FORWARD,
    NAVIGATION_RELOAD,
    NAVIGATION_FORM_RESUBMITTED,
    NAVIGATION_OTHER,
}

alias cef_xml_encoding_type_t = int;
enum {
    XML_ENCODING_NONE = 0,
    XML_ENCODING_UTF8,
    XML_ENCODING_UTF16LE,
    XML_ENCODING_UTF16BE,
    XML_ENCODING_ASCII,
}

alias cef_xml_node_type_t = int;
enum {
    XML_NODE_UNSUPPORTED = 0,
    XML_NODE_PROCESSING_INSTRUCTION,
    XML_NODE_DOCUMENT_TYPE,
    XML_NODE_ELEMENT_START,
    XML_NODE_ELEMENT_END,
    XML_NODE_ATTRIBUTE,
    XML_NODE_TEXT,
    XML_NODE_CDATA,
    XML_NODE_ENTITY_REFERENCE,
    XML_NODE_WHITESPACE,
    XML_NODE_COMMENT,
}

struct cef_popup_features_t {
    int x;
    int xSet;
    int y;
    int ySet;
    int width;
    int widthSet;
    int height;
    int heightSet;
    int menuBarVisible;
    int statusBarVisible;
    int toolBarVisible;
    int locationBarVisible;
    int scrollbarsVisible;
    int resizable;
    int fullscreen;
    int dialog;
    cef_string_list_t additionalFeatures;
}

alias cef_dom_document_type_t = int;
enum {
    DOM_DOCUMENT_TYPE_UNKNOWN = 0,
    DOM_DOCUMENT_TYPE_HTML,
    DOM_DOCUMENT_TYPE_XHTML,
    DOM_DOCUMENT_TYPE_PLUGIN,
}

alias cef_dom_event_category_t = int;
enum {
    DOM_EVENT_CATEGORY_UNKNOWN = 0x0,
    DOM_EVENT_CATEGORY_UI = 0x1,
    DOM_EVENT_CATEGORY_MOUSE = 0x2,
    DOM_EVENT_CATEGORY_MUTATION = 0x4,
    DOM_EVENT_CATEGORY_KEYBOARD = 0x8,
    DOM_EVENT_CATEGORY_TEXT = 0x10,
    DOM_EVENT_CATEGORY_COMPOSITION = 0x20,
    DOM_EVENT_CATEGORY_DRAG = 0x40,
    DOM_EVENT_CATEGORY_CLIPBOARD = 0x80,
    DOM_EVENT_CATEGORY_MESSAGE = 0x100,
    DOM_EVENT_CATEGORY_WHEEL = 0x200,
    DOM_EVENT_CATEGORY_BEFORE_TEXT_INSERTED = 0x400,
    DOM_EVENT_CATEGORY_OVERFLOW = 0x800,
    DOM_EVENT_CATEGORY_PAGE_TRANSITION = 0x1000,
    DOM_EVENT_CATEGORY_POPSTATE = 0x2000,
    DOM_EVENT_CATEGORY_PROGRESS = 0x4000,
    DOM_EVENT_CATEGORY_XMLHTTPREQUEST_PROGRESS = 0x8000,
    DOM_EVENT_CATEGORY_BEFORE_LOAD = 0x10000,
}

alias cef_dom_event_phase_t = int;
enum {
    DOM_EVENT_PHASE_UNKNOWN = 0,
    DOM_EVENT_PHASE_CAPTURING,
    DOM_EVENT_PHASE_AT_TARGET,
    DOM_EVENT_PHASE_BUBBLING,
}

alias cef_dom_node_type_t = int;
enum {
    DOM_NODE_TYPE_UNSUPPORTED = 0,
    DOM_NODE_TYPE_ELEMENT,
    DOM_NODE_TYPE_ATTRIBUTE,
    DOM_NODE_TYPE_TEXT,
    DOM_NODE_TYPE_CDATA_SECTION,
    DOM_NODE_TYPE_ENTITY,
    DOM_NODE_TYPE_PROCESSING_INSTRUCTIONS,
    DOM_NODE_TYPE_COMMENT,
    DOM_NODE_TYPE_DOCUMENT,
    DOM_NODE_TYPE_DOCUMENT_TYPE,
    DOM_NODE_TYPE_DOCUMENT_FRAGMENT,
    DOM_NODE_TYPE_NOTATION,
    DOM_NODE_TYPE_XPATH_NAMESPACE,
}

alias cef_file_dialog_mode_t = int;
enum {
    FILE_DIALOG_OPEN,
    FILE_DIALOG_OPEN_MULTIPLE,
    FILE_DIALOG_SAVE,
}

alias cef_geoposition_error_code_t = int;
enum {
    GEOPOSITION_ERROR_NONE = 0,
    GEOPOSITION_ERROR_PERMISSION_DENIED,
    GEOPOSITION_ERROR_POSITION_UNAVAILABLE,
    GEOPOSITION_ERROR_TIMEOUT,
}

struct cef_geoposition_t {
    double latitude;
    double longitude;
    double altitude;
    double accuracy;
    double altitude_accuracy;
    double heading;
    double speed;
    cef_time_t timestamp;
    cef_geoposition_error_code_t error_code;
    cef_string_t error_message;
}

// cef_types_win.h
static if( Derelict_OS_Windows ) {
    private import core.sys.windows.windows;

    alias cef_cursor_handle_t = HCURSOR;
    alias cef_event_handle_t = MSG*;
    alias cef_window_handle_t = HWND;
    alias cef_text_input_context_t = void*;

    struct cef_main_args_t {
        HINSTANCE instance;
    }

    struct cef_window_info_t {
        DWORD ex_style;
        cef_string_t window_name;
        DWORD style;
        int x;
        int y;
        int width;
        int height;
        cef_window_handle_t parent_window;
        HMENU menu;
        BOOL window_rendering_disabled;
        BOOL transparent_painting;
        cef_window_handle_t window;
    }
} else {
    static assert( 0, "derelict.cef.typesos is not yet implemented on this platform." );
}

// cef_app_capi.h
struct cef_app_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_app_t*,const( cef_string_t )*,cef_command_line_t* ) on_before_command_line_processing;
        void function( cef_app_t*,cef_scheme_registrar_t* ) on_register_custom_schemes;
        cef_resource_bundle_handler_t* function( cef_app_t* ) get_resource_bundle_handler;
        cef_browser_process_handler_t* function( cef_app_t* ) get_browser_process_handler;
        cef_render_process_handler_t* function( cef_app_t* ) get_render_process_handler;
    }
}

// cef_auth_callback_capi.h
struct cef_auth_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_auth_callback_t*,const( cef_string_t )*,const( cef_string_t )* ) cont;
        void function( cef_auth_callback_t* ) cancel;
    }
}

// cef_base_capi.h
struct cef_base_t {
    size_t size;
    extern( System ) @nogc nothrow {
        int function( cef_base_t* ) add_ref;
        int function( cef_base_t* ) release;
        int function( cef_base_t* ) get_refct;
    }
}

// cef_browser_capi.h
struct cef_browser_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_browser_host_t* function( cef_browser_t* ) get_host;
        int function( cef_browser_t* ) can_go_back;
        void function( cef_browser_t* ) go_back;
        int function( cef_browser_t* ) can_go_forward;
        void function( cef_browser_t* ) go_forward;
        int function( cef_browser_t* ) is_loading;
        void function( cef_browser_t* ) reload;
        void function( cef_browser_t* ) reload_ignore_cache;
        void function( cef_browser_t* ) stop_load;
        int function( cef_browser_t* ) get_identifier;
        int function( cef_browser_t*,cef_browser_t* ) is_same;
        int function( cef_browser_t* ) is_popup;
        int function( cef_browser_t* ) has_document;
        cef_frame_t* function( cef_browser_t* ) get_main_frame;
        cef_frame_t* function( cef_browser_t* ) get_focused_frame;
        cef_frame_t* function( cef_browser_t*,int64 ) get_frame_byident;
        cef_frame_t* function( cef_browser_t*,const( cef_string_t )* ) get_frame;
        size_t function( cef_browser_t* ) get_frame_count;
        void function( cef_browser_t*,size_t*,int64* ) get_frame_identifiers;
        void function( cef_browser_t*,cef_string_list_t ) get_frame_names;
        int function( cef_browser_t*,cef_process_id_t,cef_process_message_t* ) send_process_message;
    }
}

struct cef_run_file_dialog_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_run_file_dialog_callback_t*,cef_browser_host_t*,cef_string_list_t ) cont;
}

struct cef_browser_host_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_browser_t* function( cef_browser_host_t* ) get_browser;
        void function( cef_browser_host_t* ) parent_window_will_close;
        void function( cef_browser_host_t*,int ) close_browser;
        void function( cef_browser_host_t*,int ) set_focus;
        void function( cef_browser_host_t*,int ) set_window_visibility;
        cef_window_handle_t function( cef_browser_host_t* ) get_window_handle;
        cef_window_handle_t function( cef_browser_host_t* ) get_opener_window_handle;
        cef_client_t* function( cef_browser_host_t* ) get_client;
        cef_request_context_t* function( cef_browser_host_t* ) get_request_context;
        double function( cef_browser_host_t*) get_zoom_level;
        void function( cef_browser_host_t* ) set_zoom_level;
        void function( cef_browser_host_t*,cef_file_dialog_mode_t,const( cef_string_t )*,const( cef_string_t )*,cef_string_list_t,cef_run_file_dialog_callback_t* ) run_file_dialog;
        void function( cef_browser_host_t*,const( cef_string_t )* ) start_download;
        void function( cef_browser_host_t* ) print;
        void function( cef_browser_host_t*,int,const( cef_string_t )*,int,int,int ) find;
        void function( cef_browser_host_t*,int ) stop_finding;
        void function( cef_browser_host_t*,const( cef_window_info_t )*,cef_client_t*,const( cef_browser_settings_t)* ) show_dev_tools;
        void function( cef_browser_host_t* ) close_dev_tools;
        void function( cef_browser_host_t*,int ) set_mouse_cursor_change_disabled;
        int function( cef_browser_host_t* ) is_mouse_cursor_change_disabled;
        int function( cef_browser_host_t* ) is_window_rendering_disabled;
        void function( cef_browser_host_t* ) was_resized;
        void function( cef_browser_host_t*,int ) was_hidden;
        void function( cef_browser_host_t* ) notify_screen_info_changed;
        void function( cef_browser_host_t*,const( cef_rect_t )*,cef_paint_element_type_t ) invalidate;
        void function( cef_browser_host_t*,const( cef_key_event_t )* ) send_key_event;
        void function( cef_browser_host_t*,const( cef_mouse_event_t )*,cef_mouse_button_type_t,int,int ) send_mouse_click_event;
        void function( cef_browser_host_t*,const( cef_mouse_event_t )*,int ) send_mouse_move_event;
        void function( cef_browser_host_t*,const( cef_mouse_event_t )*,int,int ) send_mouse_wheel_event;
        void function( cef_browser_host_t*,int ) send_focus_event;
        void function( cef_browser_host_t* ) send_capture_lost;
        cef_text_input_context_t function( cef_browser_host_t* ) get_nstext_input_context;
        void function( cef_browser_host_t*,cef_event_handle_t ) handle_key_event_before_text_input_client;
        void function( cef_browser_host_t*,cef_event_handle_t ) handle_key_event_after_text_input_client;
    }
}

// cef_browser_process_handler_capi
struct cef_browser_process_handler_t  {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_browser_process_handler_t* ) on_context_initialized;
        void function( cef_browser_process_handler_t*,cef_command_line_t* ) on_before_child_process_launch;
        void function( cef_browser_process_handler_t*,cef_list_value_t* ) on_render_process_thread_created;
    }
}

// cef_callback_capi.h
struct cef_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_callback_t* ) cont;
        void function( cef_callback_t* ) cancel;
    }
}

struct cef_completion_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_completion_handler_t* ) on_complete;
}

// cef_client_capi.h
struct cef_client_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_context_menu_handler_t* function( cef_client_t* ) get_context_menu_handler;
        cef_dialog_handler_t* function( cef_client_t* ) get_dialog_handler;
        cef_display_handler_t* function( cef_client_t* ) get_display_handler;
        cef_download_handler_t* function( cef_client_t* ) get_download_handler;
        cef_drag_handler_t* function( cef_client_t* ) get_drag_handler;
        cef_focus_handler_t* function( cef_client_t* ) get_focus_handler;
        cef_geolocation_handler_t* function( cef_client_t* ) get_geolocation_handler;
        cef_jsdialog_handler_t* function( cef_client_t* ) get_jsdialog_handler;
        cef_keyboard_handler_t* function( cef_client_t* ) get_keyboard_handler;
        cef_life_span_handler_t* function( cef_client_t* ) get_life_span_handler;
        cef_load_handler_t* function( cef_client_t* ) get_load_handler;
        cef_render_handler_t* function( cef_client_t* ) get_render_handler;
        cef_request_handler_t* function( cef_client_t*) get_request_handler;
    }
}

// cef_command_line_capi.h
struct cef_command_line_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_command_line_t* ) is_valid;
        int function( cef_command_line_t* ) is_read_only;
        cef_command_line_t* function( cef_command_line_t* ) copy;
        void function( cef_command_line_t*,int,const( char* )* ) init_from_argv;
        void function( cef_command_line_t*,const( cef_string_t )* ) init_from_string;
        void function( cef_command_line_t* ) reset;
        void function( cef_command_line_t*,cef_string_list_t ) get_argv;
        cef_string_userfree_t function( cef_command_line_t* ) get_command_line_string;
        cef_string_userfree_t function( cef_command_line_t* ) get_program;
        void function( cef_command_line_t*,const( cef_string_t )* ) set_program;
        int function( cef_command_line_t* ) has_switches;
        int function( cef_command_line_t*,const( cef_string_t )* ) has_switch;
        cef_string_userfree_t function( cef_command_line_t*,const( cef_string_t )* ) get_switch_value;
        void function( cef_command_line_t*,cef_string_map_t ) get_switches;
        void function( cef_command_line_t*,const( cef_string_t )* ) append_switch;
        void function( cef_command_line_t*,const( cef_string_t )*,const( cef_string_t )* ) append_switch_with_value;
        int function( cef_command_line_t* ) has_arguments;
        void function( cef_command_line_t*,cef_string_list_t ) get_arguments;
        void function( cef_command_line_t*,const( cef_string_t )* ) append_argument;
        void function( cef_command_line_t*,const( cef_string_t )* ) prepend_wrapper;
    }
}

// cef_context_menu_handler_capi.h
struct cef_context_menu_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_context_menu_handler_t*,cef_browser_t*,cef_frame_t*,cef_context_menu_params_t*,cef_menu_model_t* ) on_before_context_menu;
        int function( cef_context_menu_handler_t*,cef_browser_t*,cef_frame_t*,cef_context_menu_params_t*,int,cef_event_flags_t ) on_context_menu_command;
        int function( cef_context_menu_handler_t*,cef_browser_t*,cef_frame_t* ) on_context_menu_dismissed;
    }
}

struct cef_context_menu_params_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_context_menu_params_t* ) get_xcoord;
        int function( cef_context_menu_params_t* ) get_ycoord;
        cef_context_menu_type_flags_t function( cef_context_menu_params_t* ) get_type_flags;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_link_url;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_unfiltered_link_url;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_source_url;
        int function( cef_context_menu_params_t* ) has_image_contents;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_page_url;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_frame_url;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_frame_charset;
        cef_context_menu_media_type_t function( cef_context_menu_params_t* ) get_media_type;
        cef_context_menu_media_state_flags_t function( cef_context_menu_params_t* ) get_media_state_flags;
        cef_string_userfree_t function( cef_context_menu_params_t* ) get_selection_text;
        int function( cef_context_menu_params_t*) is_editable;
        int function( cef_context_menu_params_t* ) is_speech_input_enabled;
        cef_context_menu_edit_state_flags_t function( cef_context_menu_params_t* ) get_edit_state_flags;
    }
}

// cef_cookie_capi.h
struct cef_cookie_manager_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_cookie_manager_t*,cef_string_list_t ) set_supported_schemes;
        int function( cef_cookie_manager_t*,cef_cookie_visitor_t* ) visit_all_cookies;
        int function( cef_cookie_manager_t*,cef_cookie_visitor_t* ) visit_url_cookies;
        int function( cef_cookie_manager_t*,const( cef_string_t )*,const( cef_cookie_t )* ) set_cookie;
        int function( cef_cookie_manager_t*,const( cef_string_t )*,const( cef_string_t )* ) delete_cookie;
        int function( cef_cookie_manager_t*,const( cef_string_t )*,int ) set_storage_path;
        int function( cef_cookie_manager_t*,cef_completion_handler_t* ) flush_store;
    }
}

struct cef_cookie_visitor_t {
    cef_base_t base;
    extern( System ) @nogc nothrow int function( cef_cookie_visitor_t*,const( cef_cookie_t )*,int,int,int* ) visit;
}

// cef_dialog_handler_capi.h
struct cef_file_dialog_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_file_dialog_callback_t*,cef_string_list_t ) cont;
        void function( cef_file_dialog_callback_t* ) cancel;
    }
}

struct cef_dialog_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow int function( cef_dialog_handler_t*,cef_browser_t*,cef_file_dialog_mode_t,const( cef_string_t )*,const( cef_string_t )*,cef_string_list_t,cef_file_dialog_callback_t* ) on_file_dialog;
}

// cef_display_handler_capi.h
struct cef_display_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_display_handler_t*,cef_browser_t*,cef_frame_t*,const( cef_string_t )* ) on_address_change;
        void function( cef_display_handler_t*,cef_browser_t*,const( cef_string_t )* ) on_title_change;
        int function( cef_display_handler_t*, cef_browser_t,cef_string_t* ) on_tooltip;
        void function( cef_display_handler_t*,cef_browser_t*,const( cef_string_t )* ) on_status_message;
        int function( cef_display_handler_t*,cef_browser_t*,const( cef_string_t )*,const( cef_string_t )*,int ) on_console_message;
    }
}

// cef_dom_capi.h
struct cef_domvisitor_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_domvisitor_t*,cef_domdocument_t* ) visit;
}
struct cef_domdocument_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_dom_document_type_t function( cef_domdocument_t* ) get_type;
        cef_domnode_t* function( cef_domdocument_t* ) get_document;
        cef_domnode_t* function( cef_domdocument_t* ) get_body;
        cef_domnode_t* function( cef_domdocument_t* ) get_head;
        cef_string_userfree_t function( cef_domdocument_t* ) get_title;
        cef_domnode_t* function( cef_domdocument_t*,const( cef_string_t )* ) get_element_by_id;
        cef_domnode_t* function( cef_domdocument_t* ) get_focused_node;
        int function( cef_domdocument_t* ) has_selection;
        cef_domnode_t* function( cef_domdocument_t*) get_selection_start_node;
        int function( cef_domdocument_t* ) get_selection_start_offset;
        cef_domnode_t* function( cef_domdocument_t* ) get_selection_end_node;
        int function( cef_domdocument_t* ) get_selection_end_offset;
        cef_string_userfree_t function( cef_domdocument_t* ) get_selection_as_markup;
        cef_string_userfree_t function( cef_domdocument_t* ) get_selection_as_text;
        cef_string_userfree_t function( cef_domdocument_t* ) get_base_url;
        cef_string_userfree_t function( cef_domdocument_t*,const( cef_string_t )* ) get_complete_url;
    }
}

struct cef_domnode_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_dom_node_type_t function( cef_domnode_t* ) get_type;
        int function( cef_domnode_t* ) is_text;
        int function( cef_domnode_t* ) is_element;
        int function( cef_domnode_t* ) is_editable;
        int function( cef_domnode_t* ) is_form_control_element;
        cef_string_userfree_t function( cef_domnode_t* ) get_form_control_element_type;
        int function( cef_domnode_t*,cef_domnode_t* ) is_same;
        cef_string_userfree_t function( cef_domnode_t* ) get_name;
        cef_string_userfree_t function( cef_domnode_t* ) get_value;
        int function( cef_domnode_t*,const( cef_string_t )* ) set_value;
        cef_string_userfree_t function( cef_domnode_t* ) get_as_markup;
        cef_domdocument_t* function( cef_domnode_t* ) get_document;
        cef_domnode_t* function( cef_domnode_t* ) get_parent;
        cef_domnode_t* function( cef_domnode_t* ) get_previous_sibling;
        cef_domnode_t* function( cef_domnode_t* ) get_next_sibling;
        int function( cef_domnode_t* ) has_children;
        cef_domnode_t* function( cef_domnode_t* ) get_first_child;
        cef_domnode_t* function( cef_domnode_t* ) get_last_child;
        void function( cef_domnode_t*,const( cef_string_t )*,cef_domevent_listener_t*,int ) add_event_listener;
        cef_string_userfree_t function( cef_domnode_t* ) get_element_tag_name;
        int function( cef_domnode_t* ) has_element_attributes;
        int function( cef_domnode_t*,const( cef_string_t )* ) has_element_attribute;
        cef_string_userfree_t function( cef_domnode_t*,const( cef_string_t )* ) get_element_attribute;
        void function( cef_domnode_t*,cef_string_map_t ) get_element_attributes;
        int function( cef_domnode_t* ,const( cef_string_t )*,const( cef_string_t )* ) set_element_attribute;
        cef_string_userfree_t function( cef_domnode_t* ) get_element_inner_text;
    }
}

struct cef_domevent_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_string_userfree_t function( cef_domevent_t* ) get_type;
        cef_dom_event_category_t function( cef_domevent_t* ) get_category;
        cef_dom_event_phase_t function( cef_domevent_t* ) get_phase;
        int function( cef_domevent_t* ) can_bubble;
        int function( cef_domevent_t* ) can_cancel;
        cef_domdocument_t* function( cef_domevent_t* ) get_document;
        cef_domnode_t* function( cef_domevent_t* ) get_target;
        cef_domnode_t* function( cef_domevent_t* ) get_current_target;
    }
}

struct cef_domevent_listener_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_domevent_listener_t*,cef_domevent_t* ) handle_event;
}

// cef_download_handler_capi.h
struct cef_before_download_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_before_download_callback_t,const( cef_string_t )*,int ) cont;
}

struct cef_download_item_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_download_item_callback_t* ) cancel;
}

struct cef_download_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_download_handler_t*,cef_browser_t*,cef_download_item_t*,const( cef_string_t )*,cef_before_download_callback_t* ) on_before_download;
        void function( cef_download_handler_t*,cef_browser_t*,cef_download_item_t*,cef_download_item_callback_t* ) on_download_updated;
    }
}

// cef_download_item_capi.h
struct cef_download_item_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_download_item_t* ) is_valid;
        int function( cef_download_item_t* ) is_in_progress;
        int function( cef_download_item_t* ) is_complete;
        int function( cef_download_item_t* ) is_canceled;
        int64 function( cef_download_item_t* ) get_current_speed;
        int function( cef_download_item_t* ) get_percent_complete;
        int64 function( cef_download_item_t* ) get_total_bytes;
        int64 function( cef_download_item_t* ) get_received_bytes;
        cef_time_t function( cef_download_item_t* ) get_start_time;
        cef_time_t function( cef_download_item_t* ) get_end_time;
        cef_string_userfree_t function( cef_download_item_t* ) get_full_path;
        uint32 function( cef_download_item_t* ) get_id;
        cef_string_userfree_t function( cef_download_item_t* ) get_url;
        cef_string_userfree_t function( cef_download_item_t* ) get_suggested_file_name;
        cef_string_userfree_t function( cef_download_item_t* ) get_content_disposition;
        cef_string_userfree_t function( cef_download_item_t* ) get_mime_type;
    }
}

// cef_drag_data_capi.h
struct cef_drag_data_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_drag_data_t* ) is_link;
        int function( cef_drag_data_t* ) is_fragment;
        int function( cef_drag_data_t* ) is_file;
        cef_string_userfree_t function( cef_drag_data_t* ) get_link_url;
        cef_string_userfree_t function( cef_drag_data_t* ) get_link_title;
        cef_string_userfree_t function( cef_drag_data_t* ) get_link_metadata;
        cef_string_userfree_t function( cef_drag_data_t* ) get_fragment_text;
        cef_string_userfree_t function( cef_drag_data_t* ) get_fragment_html;
        cef_string_userfree_t function( cef_drag_data_t* ) get_fragment_base_url;
        cef_string_userfree_t function( cef_drag_data_t* ) get_file_name;
        int function( cef_drag_data_t*,cef_string_list_t ) get_file_names;
    }
}

// cef_drag_handler_capi.h
struct cef_drag_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow int function( cef_drag_handler_t*,cef_browser_t*,cef_drag_data_t*,cef_drag_operations_mask_t ) on_drag_enter;
}

// cef_focus_handler_capi.h
struct cef_focus_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_focus_handler_t*,cef_browser_t*,int ) on_take_focus;
        int function( cef_focus_handler_t*,cef_browser_t*,cef_focus_source_t* ) on_set_focus;
        void function( cef_focus_handler_t*,cef_browser_t* ) on_get_focus;
    }
}

// cef_frame_capi.h
struct cef_frame_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_frame_t* ) is_valid;
        void function( cef_frame_t* ) undo;
        void function( cef_frame_t* ) redo;
        void function( cef_frame_t* ) cut;
        void function( cef_frame_t* ) copy;
        void function( cef_frame_t* ) paste;
        void function( cef_frame_t* ) del;
        void function( cef_frame_t*cef_drag_handler_t ) select_all;
        void function( cef_frame_t* ) view_source;
        void function( cef_frame_t*,cef_string_visitor_t* ) get_source;
        void function( cef_frame_t*,cef_string_visitor_t* ) get_text;
        void function( cef_frame_t*,cef_request_t* ) load_request;
        void function( cef_frame_t*,const( cef_string_t )* ) load_url;
        void function( cef_frame_t*,const( cef_string_t )*,const( cef_string_t )* ) load_string;
        void function( cef_frame_t*,const( cef_string_t )*,const( cef_string_t )*,int ) execute_java_script;
        int function( cef_frame_t* ) is_main;
        int function( cef_frame_t* ) is_focused;
        cef_string_userfree_t function( cef_frame_t* ) get_name;
        int64 function( cef_frame_t* ) get_identifier;
        cef_frame_t* function( cef_frame_t* ) get_parent;
        cef_string_userfree_t function( cef_frame_t* ) get_url;
        cef_browser_t* function( cef_frame_t* ) get_browser;
        cef_v8context_t* function( cef_frame_t* ) get_v8context;
        void function( cef_frame_t*,cef_domvisitor_t* ) visit_dom;

    }
}

// cef_geolocation_capi.h
struct cef_get_geolocation_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_get_geolocation_callback_t*,const( cef_geoposition_t* ) ) on_location_update;
}

// cef_geolocation_handler_capi.h
struct cef_geolocation_callback_t {
    cef_base_t basel;
    extern( System ) @nogc nothrow void function( cef_geolocation_callback_t*,int ) cont;
}

struct cef_geolocation_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_geolocation_handler_t*,cef_browser_t*,const( cef_string_t )*,int,cef_geolocation_callback_t* ) on_request_geolocation_permission;
        void function( cef_geolocation_handler_t*,cef_browser_t*,const( cef_string_t )*,int ) on_cancel_geolocation_permission;
    }
}

// cef_jsdialog_handler_capi.h
struct cef_jsdialog_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_jsdialog_callback_t*,int,const( cef_string_t )* ) cont;
}

struct cef_jsdialog_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_jsdialog_handler_t*,cef_browser_t*,const( cef_string_t )*,const( cef_string_t )*,cef_jsdialog_type_t,const( cef_string_t )*,cef_jsdialog_callback_t*,int* ) on_jsdialog;
        int function( cef_jsdialog_handler_t*,cef_browser_t*,const( cef_string_t )*,int,cef_jsdialog_callback_t* ) on_before_unload_dialog;
        void function( cef_jsdialog_handler_t*,cef_browser_t* ) on_reset_dialog_state;
        void function( cef_jsdialog_handler_t*,cef_browser_t* ) on_dialog_closed;
    }
}

// cef_keyboard_handler_capi.h
struct cef_keyboard_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_keyboard_handler_t*,cef_browser_t*,const( cef_key_event_t )*,cef_event_handle_t,int* ) on_pre_key_event;
        int function( cef_keyboard_handler_t*,cef_browser_t*,const( cef_key_event_t )*,cef_event_handle_t ) on_key_event;
    }
}

// cef_life_span_handler_capi.h
struct cef_life_span_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_life_span_handler_t*,cef_browser_t*,cef_frame_t*,const( cef_string_t )*,const( cef_string_t )*,const( cef_popup_features_t )*,cef_window_info_t*,cef_client_t**,cef_browser_settings_t*,int* ) on_before_popup;
        void function( cef_life_span_handler_t*,cef_browser_t* ) on_after_created;
        void function( cef_life_span_handler_t*,cef_browser_t* ) run_modal;
        int function( cef_life_span_handler_t*,cef_browser_t* ) do_close;
        void function( cef_life_span_handler_t*,cef_browser_t* ) on_before_close;
    }
}

// cef_load_handler_capi.h
struct cef_load_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_load_handler_t*,cef_browser_t*,int,int,int ) on_loading_state_change;
        void function( cef_load_handler_t*,cef_browser_t*,cef_frame_t* ) on_load_start;
        void function( cef_load_handler_t*,cef_browser_t*,cef_frame_t*,int ) on_load_end;
        void function( cef_load_handler_t*,cef_browser_t*,cef_frame_t*,cef_errorcode_t,const( cef_string_t )*,const( cef_string_t )* ) on_load_error;
    }
}

// cef_menu_model_capi.h
struct cef_menu_model_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_menu_model_t* ) clear;
        int function( cef_menu_model_t* ) get_count;
        int function( cef_menu_model_t* ) add_separator;
        int function( cef_menu_model_t*,int,const( cef_string_t )* ) add_item;
        int function( cef_menu_model_t*,int,const( cef_string_t )* ) add_check_item;
        int function( cef_menu_model_t*,int,const( cef_string_t )*,int ) add_radio_item;
        cef_menu_model_t* function( cef_menu_model_t*,int,const( cef_string_t )* ) add_sub_menu;
        int function( cef_menu_model_t*,int ) insert_separator_at;
        int function( cef_menu_model_t*,int,int,const( cef_string_t )* ) insert_item_at;
        int function( cef_menu_model_t*,int,int,const( cef_string_t )* ) insert_check_item_at;
        int function( cef_menu_model_t*,int,int,const( cef_string_t )*,int ) insert_radio_item_at;
        cef_menu_model_t* function( cef_menu_model_t*,int,int,const( cef_string_t )* ) insert_submenu_at;
        int function( cef_menu_model_t*,int ) remove;
        int function( cef_menu_model_t*,int ) remove_at;
        int function( cef_menu_model_t*,int ) get_index_of;
        int function( cef_menu_model_t*,int ) get_command_id_at;
        int function( cef_menu_model_t*,int,int ) set_command_id_at;
        cef_string_userfree_t function( cef_menu_model_t*,int ) get_label;
        cef_string_userfree_t function( cef_menu_model_t*,int ) get_label_at;
        int function( cef_menu_model_t*,int,const( cef_string_t )* ) set_label;
        int function( cef_menu_model_t*,int,const( cef_string_t )* ) set_label_at;
        cef_menu_item_type_t function( cef_menu_model_t*,int ) get_type;
        cef_menu_item_type_t function( cef_menu_model_t*,int ) get_type_at;
        int function( cef_menu_model_t*,int ) get_group_id;
        int function( cef_menu_model_t*,int ) get_group_id_at;
        int function( cef_menu_model_t*,int,int ) set_group_id;
        int function( cef_menu_model_t*,int,int ) set_group_id_at;
        cef_menu_model_t* function( cef_menu_model_t*,int ) get_sub_menu;
        cef_menu_model_t* function( cef_menu_model_t*,int ) get_sub_menu_at;
        int function( cef_menu_model_t*,int ) is_visible;
        int function( cef_menu_model_t*,int ) is_visible_at;
        int function( cef_menu_model_t*,int,int ) set_visible;
        int function( cef_menu_model_t*,int,int ) set_visible_at;
        int function( cef_menu_model_t*,int ) is_enabled;
        int function( cef_menu_model_t*,int ) is_enabled_at;
        int function( cef_menu_model_t*,int,int ) set_enabled;
        int function( cef_menu_model_t*,int,int ) set_enabled_at;
        int function( cef_menu_model_t*,int ) is_checked;
        int function( cef_menu_model_t*,int ) is_checked_at;
        int function( cef_menu_model_t*,int,int ) set_checked;
        int function( cef_menu_model_t*,int,int ) set_checked_at;
        int function( cef_menu_model_t*,int ) has_accelerator;
        int function( cef_menu_model_t*,int ) has_accelerator_at;
        int function( cef_menu_model_t*,int,int,int,int,int ) set_accelerator;
        int function( cef_menu_model_t*,int,int,int,int,int ) set_accelerator_at;
        int function( cef_menu_model_t*,int ) remove_accelerator;
        int function( cef_menu_model_t*,int ) remove_accelerator_at;
        int function( cef_menu_model_t*,int,int*,int*,int*,int* ) get_accelerator;
        int function( cef_menu_model_t*,int,int*,int*,int*,int* ) get_accelerator_at;
    }
}

// cef_process_message_capi.h
struct cef_process_message_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_process_message_t* ) is_valid;
        int function( cef_process_message_t* ) is_read_only;
        cef_process_message_t* function( cef_process_message_t* ) copy;
        cef_string_userfree_t function( cef_process_message_t* ) get_name;
        cef_list_value_t* function( cef_process_message_t* ) get_argument_list;
    }
}

// cef_render_handler_capi.h
struct cef_render_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_render_handler_t*,cef_browser_t*,cef_rect_t* ) get_root_screen_rect;
        int function( cef_render_handler_t*,cef_browser_t*,cef_rect_t* ) get_view_rect;
        int function( cef_render_handler_t*,cef_browser_t*,int,int,int*,int* ) get_screen_point;
        int function( cef_render_handler_t*,cef_browser_t*,cef_screen_info_t* ) get_screen_info;
        void function( cef_render_handler_t*,cef_browser_t*,int ) on_popup_show;
        void function( cef_render_handler_t*,cef_browser_t*,const( cef_rect_t )* ) on_popup_size;
        void function( cef_render_handler_t*,cef_browser_t*,cef_paint_element_type_t,size_t,const( cef_rect_t* ),const( void )*,int,int ) on_paint;
        void function( cef_render_handler_t*,cef_browser_t*,cef_cursor_handle_t ) on_cursor_change;
    }
}

// cef_render_process_handler_capi.h
struct cef_render_process_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_render_process_handler_t*,cef_list_value_t* ) on_render_thread_created;
        void function( cef_render_process_handler_t* ) on_web_kit_initialized;
        void function( cef_render_process_handler_t*,cef_browser_t* ) on_browser_created;
        void function( cef_render_process_handler_t*,cef_browser_t* ) on_browser_destroyed;
        cef_load_handler_t* function( cef_render_process_handler_t* ) get_load_handler;
        int function( cef_render_process_handler_t*,cef_browser_t*,cef_frame_t*,cef_request_t*,cef_navigation_type_t,int ) on_before_navigation;
        void function( cef_render_process_handler_t*,cef_browser_t*,cef_frame_t*,cef_v8context_t* ) on_context_created;
        void function( cef_render_process_handler_t*,cef_browser_t*,cef_frame_t*,cef_v8context_t* ) on_context_released;
        void function( cef_render_process_handler_t*,cef_browser_t*,cef_frame_t*,cef_v8context_t*,cef_v8exception_t*,cef_v8stack_trace_t* ) on_uncaught_exception;
        void function( cef_render_process_handler_t*,cef_browser_t*,cef_frame_t*,cef_domnode_t* ) on_focused_node_changed;
        int function( cef_render_process_handler_t*,cef_browser_t*,cef_process_id_t,cef_process_message_t* ) on_process_message_received;
    }
}

// cef_request_capi.h
struct cef_request_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_request_t* ) is_read_only;
        cef_string_userfree_t function( cef_request_t* ) get_url;
        void function( cef_request_t*,const( cef_string_t )* ) set_url;
        cef_string_userfree_t function( cef_request_t* ) get_method;
        void function( cef_request_t*,const( cef_string_t )* ) set_method;
        cef_post_data_t* function( cef_request_t* ) get_post_data;
        void function( cef_request_t*, cef_post_data_t* ) set_post_data;
        void function( cef_request_t*,cef_string_multimap_t ) get_header_map;
        void function( cef_request_t*,cef_string_multimap_t ) set_header_map;
        void function( cef_request_t*,const( cef_string_t )*,const( cef_string_t )*,cef_post_data_t*,cef_string_multimap_t ) set;
        int function( cef_request_t* ) get_flags;
        void function( cef_request_t*,int ) set_flags;
        cef_string_userfree_t function( cef_request_t* ) get_first_party_for_cookies;
        void function( cef_request_t*,const( cef_string_t )* ) set_first_party_for_cookies;
        cef_resource_type_t function( cef_request_t* ) get_resource_type;
        cef_transition_type_t function( cef_request_t* ) get_transition_type;
    }
}

struct cef_post_data_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_post_data_t* ) is_read_only;
        size_t function( cef_post_data_t* ) get_element_count;
        void function( cef_post_data_t*,size_t*,cef_post_data_element_t** ) get_elements;
        int function( cef_post_data_t*,cef_post_data_element_t* ) remove_element;
        int function( cef_post_data_t*,cef_post_data_element_t* ) add_element;
        void function( cef_post_data_t* ) remove_elements;
    }
}

struct cef_post_data_element_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_post_data_element_t* ) is_read_only;
        void function( cef_post_data_element_t* ) set_to_empty;
        void function( cef_post_data_element_t*,const( cef_string_t )* ) set_to_file;
        void function( cef_post_data_element_t*,size_t,const( void )* ) set_to_bytes;
        cef_postdataelement_type_t function( cef_post_data_element_t* ) get_type;
        cef_string_userfree_t function( cef_post_data_element_t* ) get_file;
        size_t function( cef_post_data_element_t* ) get_bytes_count;
        size_t function( cef_post_data_element_t*,size_t,void* ) get_bytes;
    }
}

// cef_request_context_capi.h
struct cef_request_context_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_request_context_t*,cef_request_context_t* ) is_same;
        int function( cef_request_context_t* ) is_global;
        cef_request_context_handler_t* function( cef_request_context_t* ) get_handler;
    }
}

// cef_request_context_handler_capi.h
struct cef_request_context_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow cef_cookie_manager_t* function( cef_request_context_handler_t* ) get_cookie_manager;
}

// cef_request_handler_capi.h
struct cef_quota_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_quota_callback_t*,int ) cont;
        void function( cef_quota_callback_t* ) cancel;
    }
}

struct cef_allow_certificate_error_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_allow_certificate_error_callback_t*,int ) cont;
}

struct cef_request_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_request_handler_t*,cef_browser_t*,cef_frame_t*,cef_request_t*,int ) on_before_browse;
        int function( cef_request_handler_t*,cef_browser_t*,cef_frame_t*,cef_request_t* ) on_before_resource_load;
        cef_resource_handler_t* function( cef_request_handler_t*,cef_browser_t*,cef_frame_t*,cef_request_t* ) get_resource_handler;
        void function( cef_request_handler_t*,cef_browser_t*,cef_frame_t*,const( cef_string_t )*,cef_string_t* ) on_resource_redirect;
        int function( cef_request_handler_t*,cef_browser_t*,cef_frame_t*,int,const( cef_string_t )*,int,const( cef_string_t )*,const( cef_string_t )*,cef_auth_callback_t* ) get_auth_credentials;
        int function( cef_request_handler_t*,cef_browser_t*,const( cef_string_t )*,int64,cef_quota_callback_t* ) on_quota_request;
        void function( cef_request_handler_t*,cef_browser_t*,const( cef_string_t )*,int* ) on_protocol_execution;
        int function( cef_request_handler_t*,cef_errorcode_t,const( cef_string_t )*,cef_allow_certificate_error_callback_t* ) on_certificate_error;
        int function( cef_request_handler_t*,cef_browser_t*,const( cef_string_t )*,const( cef_string_t )*,cef_web_plugin_info_t* ) on_before_plugin_load;
        void function( cef_request_handler_t*,cef_browser_t*,const( cef_string_t )* ) on_plugin_crashed;
        void function( cef_request_handler_t*,cef_browser_t*,cef_termination_status_t ) on_render_process_terminated;
    }
}

// cef_resource_bundle_handler_capi.h
struct cef_resource_bundle_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_resource_bundle_handler_t*,int,cef_string_t* ) get_localized_string;
        int function( cef_resource_bundle_handler_t*,int,void**,size_t* ) get_data_resource;
    }
}

// cef_resource_handler_capi.h
struct cef_resource_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_resource_handler_t*,cef_request_t*,cef_callback_t* ) process_request;
        void function( cef_resource_handler_t*,cef_response_t*,int64*,cef_string_t* ) get_response_headers;
        int function( cef_resource_handler_t*,void*,int,int*,cef_callback_t* ) read_response;
        int function( cef_resource_handler_t*,const( cef_cookie_t )* ) can_get_cookie;
        int function( cef_resource_handler_t*,const( cef_cookie_t )* ) can_set_cookie;
        void function( cef_resource_handler_t* ) cancel;
    }
}

// cef_reponse_capi.h
struct cef_response_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_response_t* ) is_read_only;
        int function( cef_response_t* ) get_status;
        void function( cef_response_t*,int ) set_status;
        cef_string_userfree_t function( cef_response_t* ) get_status_text;
        void function( cef_response_t*,const( cef_string_t )* ) set_status_text;
        cef_string_userfree_t function( cef_response_t* ) get_mime_type;
        void function( cef_response_t*,const( cef_string_t )* ) set_mime_type;
        cef_string_userfree_t function( cef_response_t*,const( cef_string_t )* ) get_header;
        void function( cef_response_t*,cef_string_multimap_t ) get_header_map;
        void function( cef_response_t*,cef_string_multimap_t ) set_header_map;
    }
}

// cef_scheme_capi.h
struct cef_scheme_registrar_t {
    cef_base_t base;
    extern( System ) @nogc nothrow int function( cef_scheme_registrar_t*,const( cef_string_t )*,int,int,int ) add_custom_scheme;
}

struct cef_scheme_handler_factory_t {
    cef_base_t base;
    extern( System ) @nogc nothrow cef_resource_handler_t* function( cef_scheme_handler_factory_t*,cef_browser_t*,cef_frame_t*,const( cef_string_t )*,cef_request_t* ) create;
}

// cef_stream_capi.h
struct cef_read_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        size_t function( cef_read_handler_t*,void*,size_t,size_t ) read;
        int function( cef_read_handler_t*,int64,int ) seek;
        int64 function( cef_read_handler_t* ) tell;
        int function( cef_read_handler_t* ) eof;
        int function( cef_read_handler_t* ) may_block;
    }
}

struct cef_stream_reader_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        size_t function( cef_stream_reader_t*,void*,size_t,size_t ) read;
        int function( cef_stream_reader_t*,int64,int ) seek;
        int64 function( cef_stream_reader_t* ) tell;
        int function( cef_stream_reader_t* ) eof;
        int function( cef_stream_reader_t* ) may_block;
    }
}

struct cef_write_handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        size_t function( cef_write_handler_t*,const( void )*,size_t,size_t ) write;
        int function( cef_write_handler_t*,int64,int ) seek;
        int64 function( cef_write_handler_t* ) tell;
        int function( cef_write_handler_t* ) flush;
        int function( cef_write_handler_t* ) may_block;
    }
}

struct cef_stream_writer_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        size_t function( cef_stream_writer_t*,const( void )*,size_t,size_t ) write;
        int function( cef_stream_writer_t*,int64,int ) seek;
        int64 function( cef_stream_writer_t* ) tell;
        int function( cef_stream_writer_t* ) flush;
        int function( cef_stream_writer_t* ) may_block;
    }
}

// cef_string_visitor_capi.h
struct cef_string_visitor_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_string_visitor_t*,const( cef_string_t )* ) visit;
}

// cef_task_capi.h
struct cef_task_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_task_t* ) execute;
}

struct cef_task_runner_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_task_runner_t*,cef_task_runner_t* ) is_same;
        int function( cef_task_runner_t* ) belongs_to_current_thread;
        int function( cef_task_runner_t*,cef_thread_id_t ) belongs_to_thread;
        int function( cef_task_runner_t*,cef_task_t* ) post_task;
        int function( cef_task_runner_t*,cef_task_t*,int64 ) post_delayed_task;
    }
}

// cef_trace_capi.h
struct cef_end_tracing_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_end_tracing_callback_t*,const( cef_string_t )* ) on_end_tracing_complete;
}

// cef_urlrequest_capi.h
struct cef_urlrequest_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_request_t* function( cef_urlrequest_t* ) get_request;
        cef_urlrequest_client_t* function( cef_urlrequest_t* ) get_client;
        cef_urlrequest_status_t function( cef_urlrequest_t* ) get_request_status;
        cef_errorcode_t function( cef_urlrequest_t* ) get_request_error;
        cef_response_t* function( cef_urlrequest_t* ) get_response;
        void function( cef_urlrequest_t* ) cancel;
    }
}

struct cef_urlrequest_client_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        void function( cef_urlrequest_client_t*,cef_urlrequest_t* ) on_request_complete;
        void function( cef_urlrequest_client_t*,cef_urlrequest_t*,uint64,uint64 ) on_upload_progress;
        void function( cef_urlrequest_client_t*,cef_urlrequest_t*,uint64,uint64 ) on_download_progress;
        void function( cef_urlrequest_client_t*,cef_urlrequest_t*,const( void )*,size_t ) on_download_data;
        int function( cef_urlrequest_client_t*,int,const( cef_string_t )*,int,const( cef_string_t )*,const( cef_string_t )*,cef_auth_callback_t* ) get_auth_credentials;
    }
}

// cef_v8_capi.h
struct cef_v8context_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_task_runner_t* function( cef_v8context_t* ) get_task_runner;
        int function( cef_v8context_t* ) is_valid;
        cef_browser_t* function( cef_v8context_t*cef_browser_t ) get_browser;
        cef_frame_t* function( cef_v8context_t* ) get_frame;
        cef_v8value_t* function( cef_v8context_t* ) get_global;
        int function( cef_v8context_t* ) enter;
        int function( cef_v8context_t* ) exit;
        int function( cef_v8context_t*,cef_v8context_t* ) is_same;
        int function( cef_v8context_t*,const( cef_string_t )*,cef_v8value_t**,cef_v8exception_t** ) eval;
    }
}

struct cef_v8handler_t {
    cef_base_t base;
    extern( System ) @nogc nothrow int function( cef_v8handler_t*,const( cef_string_t )*,cef_v8value_t*,size_t,const( cef_v8value_t* )*,cef_v8value_t**,cef_string_t* ) execute;
}

struct cef_v8accessor_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_v8accessor_t*,const( cef_string_t )*,cef_v8value_t*,cef_v8value_t**,cef_string_t* ) get;
        int function( cef_v8accessor_t*,const( cef_string_t )*,cef_v8value_t*,cef_v8value_t*,cef_string_t* ) set;
    }
}

struct cef_v8exception_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_string_userfree_t function( cef_v8exception_t* ) get_message;
        cef_string_userfree_t function( cef_v8exception_t* ) get_source_line;
        cef_string_userfree_t function( cef_v8exception_t* ) get_script_resource_name;
        int function( cef_v8exception_t* ) get_line_number;
        int function( cef_v8exception_t* ) get_start_position;
        int function( cef_v8exception_t* ) get_end_position;
        int function( cef_v8exception_t* ) get_start_column;
        int function( cef_v8exception_t* ) get_end_column;
    }
}

struct cef_v8value_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_v8value_t* ) is_valid;
        int function( cef_v8value_t* ) is_undefined;
        int function( cef_v8value_t* ) is_null;
        int function( cef_v8value_t* ) is_bool;
        int function( cef_v8value_t* ) is_int;
        int function( cef_v8value_t* ) is_uint;
        int function( cef_v8value_t* ) is_double;
        int function( cef_v8value_t* ) is_date;
        int function( cef_v8value_t* ) is_string;
        int function( cef_v8value_t* ) is_object;
        int function( cef_v8value_t* ) is_array;
        int function( cef_v8value_t* ) is_function;
        int function( cef_v8value_t*,cef_v8value_t* ) is_same;
        int function( cef_v8value_t* ) get_bool_value;
        int32 function ( cef_v8value_t* ) get_int_value;
        uint32 function( cef_v8value_t* ) get_uint_value;
        double function( cef_v8value_t* ) get_double_value;
        cef_time_t function( cef_v8value_t* ) get_date_value;
        cef_string_userfree_t function( cef_v8value_t* ) get_string_value;
        int function( cef_v8value_t* ) is_user_created;
        int function( cef_v8value_t* ) has_exception;
        cef_v8exception_t* function( cef_v8value_t* ) get_exception;
        int function( cef_v8value_t* ) clear_exception;
        int function( cef_v8value_t* ) will_rethrow_exception;
        int function( cef_v8value_t*,int ) set_rethrow_exception;
        int function( cef_v8value_t*,const( cef_string_t )* ) has_value_bykey;
        int function( cef_v8value_t*,int ) has_value_byindex;
        int function( cef_v8value_t*,const( cef_string_t )* ) delete_value_bykey;
        int function( cef_v8value_t*,int ) delete_value_byindex;
        cef_v8value_t* function( cef_v8value_t*,const( cef_string_t )* ) get_value_bykey;
        cef_v8value_t* function( cef_v8value_t*,int ) get_value_byindex;
        int function( cef_v8value_t*,const( cef_string_t )*,cef_v8value_t*,cef_v8_propertyattribute_t ) set_value_bykey;
        int function( cef_v8value_t*,int,cef_v8value_t* ) set_value_byindex;
        int function( cef_v8value_t*,const( cef_string_t )*,cef_v8_accesscontrol_t,cef_v8_propertyattribute_t ) set_value_byaccessor;
        int function( cef_v8value_t*,cef_string_list_t ) get_keys;
        int function( cef_v8value_t*,cef_base_t* ) set_user_data;
        cef_base_t* function( cef_v8value_t* ) get_user_data;
        int function( cef_v8value_t* ) get_externally_allocated_memory;
        int function( cef_v8value_t*,int ) adjust_externally_allocated_memory;
        int function( cef_v8value_t* ) get_array_length;
        cef_string_userfree_t function( cef_v8value_t* ) get_function_name;
        cef_v8handler_t* function( cef_v8value_t* ) get_function_handler;
        cef_v8value_t* function( cef_v8value_t*,cef_v8value_t*,size_t,const( cef_v8value_t* )* ) execute_function;
        cef_v8value_t* function( cef_v8value_t*,cef_v8context_t*,cef_v8value_t*,size_t,const( cef_v8value_t* )* ) execute_function_with_context;
    }
}

struct cef_v8stack_trace_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_v8stack_trace_t* ) is_valid;
        int function( cef_v8stack_trace_t* ) get_frame_count;
        cef_v8stack_frame_t* function( cef_v8stack_trace_t* ) get_frame;
    }
}

struct cef_v8stack_frame_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_v8stack_frame_t* ) is_valid;
        cef_string_userfree_t function( cef_v8stack_frame_t* ) get_script_name;
        cef_string_userfree_t function( cef_v8stack_frame_t* ) get_script_name_or_source_url;
        cef_string_userfree_t function( cef_v8stack_frame_t* ) get_function_name;
        int function( cef_v8stack_frame_t* ) get_line_number;
        int function( cef_v8stack_frame_t* ) get_column;
        int function( cef_v8stack_frame_t* ) is_eval;
        int function( cef_v8stack_frame_t* ) is_constructor;
    }
}

// cef_values_capi.h
struct cef_binary_value_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_binary_value_t* ) is_valid;
        int function( cef_binary_value_t* ) is_owned;
        cef_binary_value_t* function( cef_binary_value_t* ) copy;
        size_t function( cef_binary_value_t* ) get_size;
        size_t function( cef_binary_value_t*,void*,size_t,size_t ) get_data;
    }
}

struct cef_dictionary_value_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_dictionary_value_t* ) is_valid;
        int function( cef_dictionary_value_t* ) is_owned;
        int function( cef_dictionary_value_t* ) is_read_only;
        cef_dictionary_value_t* function( cef_dictionary_value_t* ) copy;
        size_t function( cef_dictionary_value_t* ) get_size;
        int function( cef_dictionary_value_t* ) clear;
        int function( cef_dictionary_value_t*,const( cef_string_t )* ) has_key;
        int function( cef_dictionary_value_t*,cef_string_list_t ) get_keys;
        int function( cef_dictionary_value_t*,const( cef_string_t )* ) remove;
        cef_value_type_t function( cef_dictionary_value_t*,const( cef_string_t )* ) get_type;
        int function( cef_dictionary_value_t*,const( cef_string_t )* ) get_bool;
        int function( cef_dictionary_value_t*,const( cef_string_t )* ) get_int;
        double function( cef_dictionary_value_t*,const( cef_string_t )* ) get_double;
        cef_string_userfree_t function( cef_dictionary_value_t*,const( cef_string_t )* ) get_string;
        cef_binary_value_t* function( cef_dictionary_value_t*,const( cef_string_t )* ) get_binary;
        cef_dictionary_value_t* function( cef_dictionary_value_t*,const( cef_string_t )* ) get_dictionary;
        cef_list_value_t* function( cef_dictionary_value_t*,const( cef_string_t )* ) get_list;
        int function( cef_dictionary_value_t*,const( cef_string_t )* ) set_null;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,int ) set_bool;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,int ) set_int;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,double ) set_double;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,const( cef_string_t )* ) set_string;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,cef_binary_value_t* ) set_binary;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,cef_dictionary_value_t* ) set_dictionary;
        int function( cef_dictionary_value_t*,const( cef_string_t )*,cef_list_value_t* ) set_list;
    }
}

struct cef_list_value_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_list_value_t* ) is_valid;
        int function( cef_list_value_t* ) is_owned;
        int function( cef_list_value_t* ) is_read_only;
        cef_list_value_t* function( cef_list_value_t* ) copy;
        int function( cef_list_value_t*,size_t ) set_size;
        size_t function( cef_list_value_t* ) get_size;
        int function( cef_list_value_t* ) clear;
        int function( cef_list_value_t*,int ) remove;
        cef_value_type_t function( cef_list_value_t*,int ) get_type;
        int function( cef_list_value_t*,int ) get_bool;
        int function( cef_list_value_t*,int ) get_int;
        double function( cef_list_value_t*,int ) get_double;
        cef_string_userfree_t function( cef_list_value_t*,int ) get_string;
        cef_binary_value_t* function( cef_list_value_t*,int ) get_binary;
        cef_dictionary_value_t* function( cef_list_value_t*,int ) get_dictionary;
        cef_list_value_t* function( cef_list_value_t*,int ) get_list;
        int function( cef_list_value_t*,int ) set_null;
        int function( cef_list_value_t*,int,int ) set_bool;
        int function( cef_list_value_t*,int,int ) set_int;
        int function( cef_list_value_t*,int,double ) set_double;
        int function( cef_list_value_t*,int,const( cef_string_t )* ) set_string;
        int function( cef_list_value_t*,int,cef_binary_value_t* ) set_binary;
        int function( cef_list_value_t*,int,cef_dictionary_value_t* ) set_dictionary;
        int function( cef_list_value_t*,int,cef_list_value_t* ) set_list;
    }
}

// cef_web_plugin_capi.h
struct cef_web_plugin_info_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        cef_string_userfree_t function( cef_web_plugin_info_t* ) get_name;
        cef_string_userfree_t function( cef_web_plugin_info_t* ) get_path;
        cef_string_userfree_t function( cef_web_plugin_info_t* ) get_version;
        cef_string_userfree_t function( cef_web_plugin_info_t* ) get_description;
    }
}

struct cef_web_plugin_info_visitor_t {
    cef_base_t base;
    extern( System ) @nogc nothrow int function( cef_web_plugin_info_visitor_t*,cef_web_plugin_info_t*,int,int ) visit;
}

struct cef_web_plugin_unstable_callback_t {
    cef_base_t base;
    extern( System ) @nogc nothrow void function( cef_web_plugin_unstable_callback_t,const( cef_string_t )*,int ) is_unstable;
}

// cef_xml_reader_capi.h
struct cef_xml_reader_t {
    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_xml_reader_t* ) move_to_next_node;
        int function( cef_xml_reader_t* ) close;
        int function( cef_xml_reader_t* ) has_error;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_error;
        cef_xml_node_type_t function( cef_xml_reader_t* ) get_type;
        int function( cef_xml_reader_t* ) get_depth;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_local_name;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_prefix;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_qualified_name;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_namespace_uri;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_base_uri;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_xml_lang;
        int function( cef_xml_reader_t* ) is_empty_element;
        int function( cef_xml_reader_t* ) has_value;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_value;
        int function( cef_xml_reader_t* ) has_attributes;
        size_t function( cef_xml_reader_t* ) get_attribute_count;
        cef_string_userfree_t function( cef_xml_reader_t*,int ) get_attribute_byindex;
        cef_string_userfree_t function( cef_xml_reader_t*,const( cef_string_t )* ) get_attribute_byqname;
        cef_string_userfree_t function( cef_xml_reader_t*,const( cef_string_t )*,const( cef_string_t )* ) get_attribute_bylname;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_inner_xml;
        cef_string_userfree_t function( cef_xml_reader_t* ) get_outer_xml;
        int function( cef_xml_reader_t* ) get_line_number;
        int function( cef_xml_reader_t*,int ) move_to_attribute_by_index;
        int function( cef_xml_reader_t*,const( cef_string_t )* ) move_to_attribute_byqname;
        int function( cef_xml_reader_t*,const( cef_string_t )*,const( cef_string_t )* ) move_to_attribute_bylname;
        int function( cef_xml_reader_t* ) move_to_first_attribute;
        int function( cef_xml_reader_t* ) move_to_next_attribute;
        int function( cef_xml_reader_t* ) move_to_carrying_element;
    }
}

// cef_zip_reader_capi.h
struct cef_zip_reader_t {
    import core.stdc.time : time_t;

    cef_base_t base;
    extern( System ) @nogc nothrow {
        int function( cef_zip_reader_t* ) move_to_first_file;
        int function( cef_zip_reader_t* ) move_to_next_file;
        int function( cef_zip_reader_t*,const( cef_string_t )*,int ) move_to_file;
        int function( cef_zip_reader_t* ) close;
        cef_string_userfree_t function( cef_zip_reader_t* ) get_file_name;
        int64 function( cef_zip_reader_t* ) get_file_size;
        time_t function( cef_zip_reader_t* ) get_file_last_modified;
        int function( cef_zip_reader_t*,const( cef_string_t )* ) open_file;
        int function( cef_zip_reader_t* ) close_file;
        int function( cef_zip_reader_t*,void*,size_t ) read_file;
        int64 function( cef_zip_reader_t* ) tell;
        int function( cef_zip_reader_t* ) eof;
    }
}
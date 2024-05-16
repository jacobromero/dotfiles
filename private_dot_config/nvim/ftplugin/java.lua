local home = os.getenv('HOME')
local jdtls = require('jdtls')

require("dapui").setup()
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
    local file = io.open(root_dir .. "/.bemol/ws_root_folders")
    if file then
        for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
        end
        file:close()
    end
end

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local bundles = {
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
};
vim.list_extend(bundles, vim.split(vim.fn.glob("/home/jpromero/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n"))

local config = {
    flags = {
        debounce_text_changes = 75,
    },
    on_attach = on_attach,  -- We pass our on_attach keybindings to the configuration map
    root_dir = root_dir, -- Set the root directory to our found root_marker
    init_options = {
        workspaceFodlers = ws_folders_jdtls,
        bundles = bundles,
    },
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#i/nitialize-request
    -- for a list of options
    settings = {
        java = {
            format = {
                enabled = true,
                settings = {
                    url = home .. '/.local/share/nvim/mason/packages/jdtls/format.xml',
                    profile = "formatter",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                enabled = true,
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
                importOrder = {
                    'java',
                    'javax',
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            imports = {
                annotationProcessing = {
                    enabled = true,
                },
            }
        },
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        'java',
        '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar',
        '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
        '-data', workspace_folder
    },
}
        -- "jdtls",
        -- "--jvm-arg=-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok-1.18.28.jar",
        -- "--jvm-arg=-Xbootclasspath/a:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok-1.18.28.jar",
        -- "-data", eclipse_workspace,

function bemol()
    local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory'})[1]
    local ws_folders_lsp = {}
    if bemol_dir then
        local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
        if file then

            for line in file:lines() do
                table.insert(ws_folders_lsp, line)
            end
            file:close()
        end
    end

    for _, line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end
bemol()

local dap = require('dap')
-- dap.configurations.java = {
--     {
--         type = 'java';
--         request = 'attach';
--         name = "Debug (Attach) - Remote";
--         hostName = "127.0.0.1";
--         port = 7000;
--     },
-- }
-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)


vim.keymap.set('n', '<leader>D', function()
    dap.configurations.java = {
        {
            type = 'java';
            request = 'attach';
            name = "Debug (Attach) - Remote";
            hostName = "localhost";
            port = 7002;
        },
    }
    dap.continue()
end)

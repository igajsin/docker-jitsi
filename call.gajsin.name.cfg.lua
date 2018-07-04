-- Plugins path gets uncommented during jitsi-meet-tokens package install - that's where token plugin is located
--plugin_paths = { "/usr/share/jitsi-meet/prosody-plugins/" }

VirtualHost "call.gajsin.name"
        -- enabled = false -- Remove this line to enable this host
        authentication = "anonymous"
        -- Properties below are modified by jitsi-meet-tokens package config
        -- and authentication above is switched to "token"
        --app_id="example_app_id"
        --app_secret="example_app_secret"
        -- Assign this host a certificate for TLS, otherwise it would use the one
        -- set in the global section (if any).
        -- Note that old-style SSL on port 5223 only supports one certificate, and will always
        -- use the global one.
        ssl = {
                key = "/etc/ssl/call.gajsin.name.key";
                certificate = "/etc/ssl/call.gajsin.name.crt";
        }
        -- we need bosh
        modules_enabled = {
            "bosh";
            "pubsub";
            "ping"; -- Enable mod_ping
        }

Component "conference.call.gajsin.name" "muc"
    --modules_enabled = { "token_verification" }
admins = { "focus@auth.call.gajsin.name" }

Component "jitsi-videobridge.call.gajsin.name"
    component_secret = "pass2"

VirtualHost "auth.call.gajsin.name"
    authentication = "internal_plain"

Component "focus.call.gajsin.name"
    component_secret = "pass3"

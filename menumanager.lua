Hooks:PostHook(MenuManager, "_set_peer_sync_state", "_set_peer_sync_state_stop_lobby_lag", function(self, peer_id, state)
    if (state ~= "lobby") or (not peer_id) then
        return
    end

    local peer = managers.network:session():peer(peer_id)
    local sync_outfit_data = peer and peer._stop_lobby_lag

    if sync_outfit_data then
            local outfit_string = sync_outfit_data.outfit_string
            local outfit_version = sync_outfit_data.outfit_version
            local outfit_signature = sync_outfit_data.outfit_signature
            local sender = sync_outfit_data.sender

        --Call the sync function with the saved info as the function runs on item change
        --Means we have to call it ourselves to load the character when they change state
        managers.network._handlers.connection:sync_outfit(outfit_string, outfit_version, outfit_signature, sender)
    end
end)
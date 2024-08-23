export type Handler = (... any) -> ()

export type Bus = {
    _listeners: { [string]: { Handler }},

    new: () -> Bus,
    subscribe: (self: Bus, event_name: string, handler: Handler) -> (),
    post: (self: Bus, event_name: string, ... any) -> (),
    remove: (self: Bus, event_name: string, handler: Handler) -> (),
    clear: (self: Bus, event_name: string) -> (),
    has_listeners: (self: Bus, event_name: string) -> boolean
}

export type Color4 = {
    r: number,
    g: number,
    b: number,
    a: number,
}

return nil
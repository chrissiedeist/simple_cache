{application,simple_cache,
             [{description,"A simple caching system"},
              {vsn,"1.0.1"},
              {modules,[sc_app,sc_element,sc_store,sc_sup,simple_cache,
                        ws_handler]},
              {registered,[sc_sup]},
              {applications,[kernel,stdlib]},
              {mod,{sc_app,[]}}]}.

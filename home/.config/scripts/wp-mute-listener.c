#include <wireplumber-0.5/wp/wp.h>
#include <glib.h>
#include <stdio.h>

static void on_mixer_changed (WpPlugin *mixer, guint32 id, gpointer user_data);
static void on_default_nodes_changed (WpPlugin *def_nodes, gpointer user_data);

static gboolean
load_modules (gpointer data)
{
  WpCore *core = WP_CORE (data);

  wp_core_load_component (core,
      "libwireplumber-module-default-nodes-api",
      "module", NULL,
      "default-nodes-api", NULL, NULL, NULL);

  wp_core_load_component (core,
      "libwireplumber-module-mixer-api",
      "module", NULL,
      "mixer-api", NULL, NULL, NULL);

  return G_SOURCE_REMOVE;
}

static gboolean
check_and_connect_plugins (gpointer data)
{
  WpCore *core = WP_CORE (data);
  WpPlugin *def_nodes = wp_plugin_find (core, "default-nodes-api");
  WpPlugin *mixer     = wp_plugin_find (core, "mixer-api");

  if (def_nodes && mixer) {
    g_signal_connect (mixer, "changed",
                      G_CALLBACK (on_mixer_changed), NULL);
    g_signal_connect (def_nodes, "changed",
                      G_CALLBACK (on_default_nodes_changed), core);

    on_default_nodes_changed (def_nodes, core);

    return G_SOURCE_REMOVE;
  }

  return G_SOURCE_CONTINUE;
}

static void
on_mixer_changed (WpPlugin *mixer, guint32 id, gpointer user_data)
{
  gboolean mute = FALSE;
  GVariant *variant = NULL;

  g_signal_emit_by_name (mixer, "get-volume", id, &variant);
  if (variant) {
    g_variant_lookup (variant, "mute", "b", &mute);
    g_variant_unref (variant);

    printf("%s\n", mute ? "muted" : "unmuted");
    fflush(stdout);
  }
}

static void
on_default_nodes_changed (WpPlugin *def_nodes, gpointer user_data)
{
  WpCore *core = WP_CORE (user_data);
  WpPlugin *mixer = wp_plugin_find (core, "mixer-api");
  guint32 default_sink_id = 0;

  g_signal_emit_by_name (def_nodes,
      "get-default-node", "Audio/Sink", &default_sink_id);

  if (default_sink_id)
    on_mixer_changed (mixer, default_sink_id, NULL);
}

int
main (int argc, char *argv[])
{
  wp_init (WP_INIT_PIPEWIRE);

  WpCore *core = wp_core_new (NULL, NULL, NULL);
  if (wp_core_connect (core) <= 0) {
    g_printerr ("Failed to connect to PipeWire\n");
    return 1;
  }

  g_idle_add (load_modules, core);

  g_timeout_add (200, check_and_connect_plugins, core);

  GMainLoop *loop = g_main_loop_new (NULL, FALSE);
  g_main_loop_run (loop);

  return 0;
}

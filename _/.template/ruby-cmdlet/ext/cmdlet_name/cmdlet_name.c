#include "{{snake microapp.microapp.settings.application}}.h"

VALUE rb_m{{camelU microapp.microapp.settings.application}};

void
Init_{{snake microapp.microapp.settings.application}}(void)
{
  rb_m{{camelU microapp.microapp.settings.application}} = rb_define_module("{{camelU microapp.microapp.settings.application}}");
}

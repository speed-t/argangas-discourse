import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import DropdownMenu from "discourse/components/dropdown-menu";
import DMenu from "float-kit/components/d-menu";

export default class PostLanguageSelector extends Component {
  @service siteSettings;

  @action
  selectPostLanguage(locale) {
    this.args.composerModel.locale = locale;
    this.dMenu.close();
  }

  @action
  onRegisterApi(api) {
    this.dMenu = api;
  }

  <template>
    <DMenu
      @identifier="post-language-selector"
      @title="Post Language"
      @icon="globe"
      @label={{@selectedLanguage}}
      @modalForMobile={{true}}
      @onRegisterApi={{this.onRegisterApi}}
      @class="btn-transparent btn-small post-language-selector"
    >
      <:content>
        <DropdownMenu as |dropdown|>
          {{#each
            this.siteSettings.available_content_localization_locales
            as |locale|
          }}
            <dropdown.item
              class="locale=options"
              data-menu-option-id={{locale.value}}
            >
              <DButton
                @translatedLabel={{locale.name}}
                @title={{locale.value}}
                @action={{fn this.selectPostLanguage locale.value}}
              />
            </dropdown.item>
          {{/each}}
        </DropdownMenu>
      </:content>
    </DMenu>
  </template>
}

{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}

{% if template == 'home'%}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
    {% set section_slider = section_slider %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    {% if template == 'product'%}
        {% set section_slider = true %}
    {% endif %}
{% endif %}

{% if slide_item %}
    <div class="swiper-slide">
{% endif %}
    <div class="js-item-product{% if slide_item %} js-item-slide p-0{% endif %}{% if not slide_item %} col-{% if columns_mobile == 1 %}12{% else %}6{% endif %} col-md-{% if columns_desktop == 2 %}6{% elseif columns_desktop == 3 %}4{% else %}3{% endif %}{% endif %} item-product col-grid" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
        <div class="js-item-info-container item{% if slide_item %} mb-0{% endif %}">
            {% if settings.quick_shop or settings.product_color_variants %}
                <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}">
            {% endif %}
            {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

            {% set item_img_width = product.featured_image.dimensions['width'] %}
            {% set item_img_height = product.featured_image.dimensions['height'] %}
            {% set item_img_srcset = product.featured_image %}
            {% set item_img_alt = product.featured_image.alt %}
            {% set item_img_spacing = item_img_height / item_img_width * 100 %}
            {% set show_secondary_image = settings.product_hover and product.other_images %}

            {# Set how much viewport space the images will take to load correct image #}

            {% if params.preview %}
                {% set mobile_image_viewport_space = '100' %}
                {% set desktop_image_viewport_space = '50' %}
            {% else %}
                {% if columns_mobile == 2 %}
                    {% set mobile_image_viewport_space = '50' %}
                {% else %}
                    {% set mobile_image_viewport_space = '100' %}
                {% endif %}

                {% if columns_desktop == 4 %}
                    {% set desktop_image_viewport_space = '25' %}
                {% elseif columns_desktop == 3 %}
                    {% set desktop_image_viewport_space = '33' %}
                {% else %}
                    {% set desktop_image_viewport_space = '50' %}
                {% endif %}
            {% endif %}

            <div class="{% if show_secondary_image %}js-item-with-secondary-image{% endif %} item-image{% if columns == 1 %} item-image-big{% endif %}">
                <div style="padding-bottom: 275px"  class="js-item-image-padding position-relative" data-store="product-item-image-{{ product.id }}">
                    <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" >
                        <img alt="{{ item_img_alt }}" data-expand="-10" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ item_img_srcset | product_image_url('small')}} 240w, {{ item_img_srcset | product_image_url('medium')}} 320w, {{ item_img_srcset | product_image_url('large')}} 480w, {{ item_img_srcset | product_image_url('huge')}} 640w, {{ item_img_srcset | product_image_url('original')}} 1024w" class="js-item-image lazyautosizes lazyload img-absolute img-absolute-centered fade-in {% if show_secondary_image %}item-image-primary{% endif %}" width="{{ item_img_width }}" height="{{ item_img_height }}" sizes="(max-width: 768px) {{ mobile_image_viewport_space }}vw, (min-width: 769px) {{ desktop_image_viewport_space }}vw"/> 
                        <div class="placeholder-fade">
                        </div>

                        {% if show_secondary_image %}
                            <img alt="{{ item_img_alt }}" data-sizes="auto" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ product.other_images | first | product_image_url('small')}} 240w, {{ product.other_images | first | product_image_url('medium')}} 320w, {{ product.other_images | first | product_image_url('large')}} 480w, {{ product.other_images | first | product_image_url('huge')}} 640w, {{ product.other_images | first | product_image_url('original')}} 1024w" class="js-item-image js-item-image-secondary lazyautosizes lazyload img-absolute img-absolute-centered fade-in item-image-secondary" sizes="(min-width: 768px) {{ desktop_image_viewport_space }}vw, {{ mobile_image_viewport_space }}vw" style="display:none;" />
                        {% endif %}
                    </a>
                </div>
                {% include 'snipplets/labels.tpl' with {labels_floating: true} %}
            </div>
            {% if (settings.quick_shop or settings.product_color_variants) and product.available and product.display_price and product.variations %}

                {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}

                <div class="js-item-variants hidden">
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% if product.variations %}
                            {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                        {% endif %}
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                        {# Add to cart CTA #}

                        {% set show_product_quantity = product.available and product.display_price %}

                        <div class="row">

                            {% if show_product_quantity %}
                                {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                            {% endif %}

                            <div class="{% if show_product_quantity %}col-8 pl-md-0{% else %}col-12{% endif %} buy-button-container">

                                <input type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                                {# Fake add to cart CTA visible during add to cart event #}

                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}
                            </div>
                        </div>
                    </form>
                </div>

            {% endif %}
            {% set show_labels = not product.has_stock or product.compare_at_price or product.promotional_offer %}
            <div class="item-description text-center" data-store="product-item-info-{{ product.id }}">
                <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link">
                    <div class="js-item-name item-name mb-2 font-small opacity-80" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                    {% if product.display_price %}
                        <div class="item-price-container" data-store="product-item-price-{{ product.id }}">
                            <span class="js-price-display item-price" data-product-price="{{ product.price }}">
                                {{ product.price | money }}
                            </span>
                            <span class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %}>
                                {{ product.compare_at_price | money }}
                            </span>

                            {{ component('payment-discount-price', {
                                    visibility_condition: settings.payment_discount_price,
                                    location: 'product',
                                    container_classes: "font-smallest mt-1",
                                }) 
                            }}

                            {% if settings.product_installments %}
                                {{ component('installments', {'location' : 'product_item', container_classes: { installment: "item-installments mt-2"}}) }}
                            {% endif %}
                        </div>
                    {% endif %}
                    {% if settings.product_color_variants %}
                        {% include 'snipplets/grid/item-colors.tpl' %}
                    {% endif %}
                    {% if product.available and product.display_price and settings.quick_shop %}
                        {% if settings.quick_shop %}
                            <div class="item-actions mt-2 pt-1">
                                {% if product.variations %}

                                    {# Open quickshop popup if has variants #}

                                    <span data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" href="#" class="js-quickshop-modal-open js-fullscreen-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open btn-link" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                        <span class="js-open-quickshop-wording">{{ 'Comprar' | translate }}</span>
                                        <svg class="js-open-quickshop-icon icon-inline ml-1"><use xlink:href="#bag-small"/></svg>
                                    </span>
                                {% else %}
                                    {# If not variants add directly to cart #}
                                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                        {% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                        <div class="js-item-submit-container item-submit-container position-relative">
                                            <input type="submit" class="js-addtocart js-prod-submit-form btn-link btn-small-quickshop {{ state }}" value="{{ texts[state] | translate }}" alt="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"/>
                                            <svg class="js-quickshop-bag icon-inline item-quickshop-icon"><use xlink:href="#bag-small"/></svg>
                                        </div>

                                        {# Fake add to cart CTA visible during add to cart event #}

                                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true} %}
                                    </form>
                                {% endif %}
                            </div>
                        {% endif %}
                    {% endif %}
                </a>
            </div>
            {% if settings.quick_shop or settings.product_color_variants %}
                </div>{# This closes the quickshop tag #}
            {% endif %}

            {# Structured data to provide information for Google about the product content #}
            {{ component('structured-data', {'item': true}) }}
        </div>
    </div>
{% if slide_item %}
    </div>
{% endif %}